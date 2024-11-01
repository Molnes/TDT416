import collection.mutable.Map

class Bank(val allowedAttempts: Integer = 3) {

  private val accountsRegistry: Map[String, Account] = Map()

  val transactionsPool: TransactionPool = new TransactionPool()
  val completedTransactions: TransactionPool = new TransactionPool()

  def processing: Boolean = !transactionsPool.isEmpty

/**
 * Transfers a specified amount of money from one account to another.
 *
 * @param from The account ID to transfer money from.
 * @param to The account ID to transfer money to.
 * @param amount The amount of money to transfer.
 */
  def transfer(from: String, to: String, amount: Double): Unit = {
    transactionsPool.synchronized {
      transactionsPool.add(new Transaction(from, to, amount, allowedAttempts))
    }
  }

/**
 * Processes all the transactions in the bank system.
 * This method handles the logic for processing various types of transactions
 * such as deposits, withdrawals, and transfers.
 */
  def processTransactions: Unit = {
    if (transactionsPool.isEmpty) return
      val workers: List[Thread] = transactionsPool.iterator.toList
        .filter(_.getStatus() == TransactionStatus.PENDING)
        .map(processSingleTransaction)

      workers.foreach(element => element.start())
      workers.foreach(element => element.join())

      /* TODO: change to select only transactions that succeeded */
      val succeded: List[Transaction] = transactionsPool.iterator.toList
        .filter(_.getStatus() == TransactionStatus.SUCCESS)

      /* TODO: change to select only transactions that failed */
      val failed: List[Transaction] = transactionsPool.iterator.toList
        .filter(_.getStatus() == TransactionStatus.FAILED)

      succeded.map(transactionsPool.remove(_))
      succeded.map(completedTransactions.add(_))

      failed.map(t => {
        if (t.getAttempts() >= t.retries) {
          transactionsPool.remove(t)
          completedTransactions.add(t)
        } else {
          transactionsPool.remove(t)
          t.incrementAttempts()
          t.setStatus(TransactionStatus.PENDING)
          transactionsPool.add(t)
        }
      })

      if (!transactionsPool.isEmpty) {
        processTransactions
      }
  }
/**
 * Processes a single transaction in a separate thread.
 *
 * @param t The transaction to be processed.
 * @return A thread that processes the given transaction.
 */
  private def processSingleTransaction(t: Transaction): Thread = {
    return new Thread {
      override def run(): Unit = {
        accountsRegistry.synchronized {
          val fromAccount = getAccount(t.from)
          val toAccount = getAccount(t.to)

          val monney = t.amount

          if (fromAccount.isDefined && toAccount.isDefined) {
            val from = fromAccount.get
            val to = toAccount.get
            from.withdraw(monney) match {
              case Left(_) => t.setStatus(TransactionStatus.FAILED)
              case Right(newFrom) => {
                to.deposit(monney) match {
                  case Left(_) => {
                    from.deposit(monney)

                    t.setStatus(TransactionStatus.FAILED)
                  }
                  case Right(newTo) => {

                    replaceAccount(from.code, newFrom)
                    replaceAccount(to.code, newTo)

                    t.setStatus(TransactionStatus.SUCCESS)
                  }
                }
              }
            }
          } else {
            t.setStatus(TransactionStatus.FAILED)
          }
        }
      }
    }
  }

/**
 * Creates a new bank account with the specified initial balance.
 *
 * @param initialBalance The initial balance to be set for the new account.
 * @return A unique identifier (UUID) for the newly created account.
 */
  def createAccount(initialBalance: Double): String = {
    val code = java.util.UUID.randomUUID.toString
    accountsRegistry += (code -> new Account(code, initialBalance))
    code
  }

/**
 * Retrieves an account from the accounts registry.
 * 
 * @param code The unique identifier for the account to be retrieved.
 * @return An optional account if it exists in the registry.
 *        None otherwise.
 */
  def getAccount(code: String): Option[Account] = {
    accountsRegistry.get(code)
  }

/**
 * Replaces an existing account in the accounts registry with a new account.
 *
 * @param code The unique identifier for the account to be replaced.
 * @param account The new account to replace the existing one.
 */
  def replaceAccount(code: String, account: Account): Unit = {
    accountsRegistry += (code -> account)
  }
}
