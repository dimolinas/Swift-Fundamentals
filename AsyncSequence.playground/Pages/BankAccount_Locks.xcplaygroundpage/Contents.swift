import UIKit

final class BankAccount: @unchecked Sendable {
    private var balance: Double
    private let lock = NSLock()
    
    init(balance: Double) {
        self.balance = balance
    }
    
    
    func withdraw(_ amount: Double) {
        
        lock.lock()
        defer { lock.unlock() }
        if balance >= amount {
            let processingTime = UInt32.random(in: 0...3)
            print("[Withdraw] Processing for \(amount) \(processingTime) seconds")
            sleep(processingTime)
            print("Withdraw \(amount) from account")
            balance -= amount
            print("Balance is \(balance)")
        } else {
            print("Insufficient funds for withdrawal of \(amount)")
        }
        
    }
}


let bankAccount = BankAccount(balance: 500)

let queue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)

queue.async {
    bankAccount.withdraw(300)
}

queue.async {
    bankAccount.withdraw(500)
}


