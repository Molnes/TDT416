
class Account(val code : String, val balance: Double) {

    // TODO
    // Implement functions. Account should be immutable.
    // Change return type to the appropriate one
    def withdraw(amount: Double) : Either[String, Account] = {
        if (amount < 0) {
            Left("Withdrawal amount cannot be negative")
        } else if (amount > balance) {
            Left("Insufficient funds")
        } else {
            Right(new Account(code, balance-amount))
        }
    }

    def deposit (amount: Double) : Either[String, Account] = {
        if (amount < 0) {
            Left("Deposit amount cannot be negative")
        } else {
            Right(new Account(code, balance+amount))
        }
    }

}
