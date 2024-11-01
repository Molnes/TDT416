
class Account(val code : String, val balance: Double) {

    // TODO
    // Implement functions. Account should be immutable.
    // Change return type to the appropriate one
    def withdraw(amount: Double) : Account = {
        new Account(code, balance-amount)
    }

    def deposit (amount: Double) : Account = {
        new Account(code, balance+amount)
    }

}
