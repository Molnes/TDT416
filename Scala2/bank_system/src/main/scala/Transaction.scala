object TransactionStatus extends Enumeration {
  val SUCCESS, PENDING, FAILED = Value
}

class TransactionPool {

  val pool = new scala.collection.mutable.Queue[Transaction]()

  /**
    * Remove a transaction from the pool
    *
    * @param t the transaction to remove
    * @return true if the transaction was removed, false otherwise
    */
  def remove(t: Transaction): Boolean = {
    pool.dequeueFirst(_ == t) match {
      case Some(_) => true
      case None    => false
    }
  }

  /**
    * Check if the pool is empty
    *
    * @return true if the pool is empty, false otherwise
    */
  def isEmpty: Boolean = {
    pool.isEmpty
  }

  /**
    * Return the size of the pool
    *
    * @return the size of the pool
    */
  def size: Integer = {
    pool.size
  }

  /**
    * Add a transaction to the pool
    *
    * @param t the transaction to add
    * @return true if the transaction was added, false otherwise
    */
  def add(t: Transaction): Boolean = {
    pool.enqueue(t)
    true

  }

  /**
    * Returns an iterator over the elements in this pool.
    *
    * @return an iterator over the elements in this pool.
    */
  def iterator: Iterator[Transaction] = {
    pool.iterator
  }

}

class Transaction(
    val from: String,
    val to: String,
    val amount: Double,
    val retries: Int = 3
) {

  private var status: TransactionStatus.Value = TransactionStatus.PENDING
  private var attempts = 0

  def getStatus() = status

  /**
   * Sets the status of the transaction to the specified new status.
   *
   * @param newStatus The new status to set for the transaction.
   */
  def setStatus(newStatus: TransactionStatus.Value) = {
    status = newStatus
  }

  def getAttempts() = attempts

  /**
    * Increments the number of attempts made to process the transaction.
    *
    * @return the new number of attempts made to process the transaction.
    */
  def incrementAttempts(): Int = {
    attempts += 1
    attempts
  }
}
