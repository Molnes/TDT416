import collection.mutable.Map

class Bank(val allowedAttempts: Integer = 3) {

  private val accountsRegistry: Map[String, Account] = Map()

  val transactionsPool: TransactionPool = new TransactionPool()
  val completedTransactions: TransactionPool = new TransactionPool()

  def processing: Boolean = !transactionsPool.isEmpty

  def transfer(from: String, to: String, amount: Double): Unit = {
    transactionsPool.synchronized {
      transactionsPool.add(new Transaction(from, to, amount, allowedAttempts))
    }
  }

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

  def createAccount(initialBalance: Double): String = {
    val code = java.util.UUID.randomUUID.toString
    accountsRegistry += (code -> new Account(code, initialBalance))
    code
  }

  def getAccount(code: String): Option[Account] = {
    accountsRegistry.get(code)
  }

  def replaceAccount(code: String, account: Account): Unit = {
    accountsRegistry += (code -> account)
  }
}
