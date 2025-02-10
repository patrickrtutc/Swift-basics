//: [Previous](@previous)

import Foundation

enum TransactionType {
    case deposit(amount: Double)
    case withdrawal(amount: Double)
    case transfer(amount: Double, toAccount: String)
    case savings(amount: Double, interestRate: Double)
}

// Custom Stack with Generics
struct Stack<T> {
    private var objects: [T] = []
    
    mutating func push(_ object: T) {
        objects.append(object)
    }
    
    mutating func pop() -> T? {
        return objects.popLast()
    }
    
    func getAllObjects() -> [T] {
        return objects
    }
}

// Constrain the protocol to only allow classes to conform
protocol BankAccount: AnyObject {
    var accountNumber: String { get }
    var balance: Double { get set }
    var transactionHistory: Stack<TransactionType> { get set }
    
    func deposit(amount: Double)
    func withdraw(amount: Double) -> Bool
    func getAccountSummary() -> String
}

extension BankAccount {
    func getAccountSummary() -> String {
        return """
        Account Number: \(accountNumber)
        Balance: $\(String(format: "%.2f", balance))
        """
    }
}

class RegularAccount: BankAccount {
    let accountNumber: String
    var balance: Double = 0.0
    var transactionHistory = Stack<TransactionType>()
    
    init(accountNumber: String) {
        self.accountNumber = accountNumber
    }
    
    func deposit(amount: Double) {
        balance += amount
        transactionHistory.push(.deposit(amount: amount))
    }
    
    func withdraw(amount: Double) -> Bool {
        guard amount <= balance else {
            print( "Insufficient funds" )
            return false
        }
        balance -= amount
        transactionHistory.push(.withdrawal(amount: amount))
        return true
    }
}

class SavingsAccount: RegularAccount {
    var interestRate: Double = 0.0
    
    init(accountNumber: String, interestRate: Double) {
        self.interestRate = interestRate
        super.init(accountNumber: accountNumber)
    }
    
    func applyInterest() {
        deposit(amount: balance * interestRate)
    }
}

class Bank {
    private var accounts: [String: RegularAccount] = [:]
    
    func addAccount(_ account: RegularAccount) {
        accounts[account.accountNumber] = account
    }
    
    func getAccount(byNumber number: String) -> BankAccount? {
        return accounts[number]
    }
    
    func performTransfer(from: String, to: String, amount: Double) -> Bool {
        guard let sourceAccount = accounts[from],
              let targetAccount = accounts[to],
              sourceAccount.withdraw(amount: amount) else {
            return false
        }
        
        targetAccount.deposit(amount: amount)
        sourceAccount.transactionHistory.push(.transfer(amount: amount, toAccount: to))
        targetAccount.transactionHistory.push(.transfer(amount: amount, toAccount: from))
        return true
    }
}
    

let bank = Bank()
let regularAccount = RegularAccount(accountNumber: "R-123")
let savingsAccount = SavingsAccount(accountNumber: "S-456", interestRate: 0.05)

bank.addAccount(regularAccount)
bank.addAccount(savingsAccount)

regularAccount.deposit(amount: 1000)
savingsAccount.deposit(amount: 5000)
bank.performTransfer(from: "R-123", to: "S-456", amount: 300)
savingsAccount.applyInterest()

print("Regular Account Summary:")
print(regularAccount.getAccountSummary())
print("\nSavings Account Summary:")
print(savingsAccount.getAccountSummary())

//: [Next](@next)
