class Account(val code: String, val balance: Double) {

  def withdraw(amount: Double): Either[String, Account] = {
    amount match {
      case x if x < 0       => Left("Withdrawal amount cannot be negative")
      case x if x > balance => Left("Insufficient funds")
      case _                => Right(new Account(code, balance - amount))
    }
  }

  def deposit(amount: Double): Either[String, Account] = {
    amount match {
      case x if x < 0 => Left("Deposit amount cannot be negative")
      case _          => Right(new Account(code, balance + amount))
    }
  }

}
