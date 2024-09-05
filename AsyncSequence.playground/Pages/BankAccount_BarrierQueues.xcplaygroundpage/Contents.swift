import UIKit

final class BankAccount  {
    private var balance: Double
    private let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)

    
    init(balance: Double) {
        self.balance = balance
    }
    
    
    func withdraw(_ amount: Double) {
        concurrentQueue.async(flags: .barrier) {
            if self.balance >= amount {
                let processingTime = UInt32.random(in: 0...3)
                print("[Withdraw] Processing for \(amount) \(processingTime) seconds")
                sleep(processingTime)
                print("Withdraw \(amount) from account")
                self.balance -= amount
                print("Balance is \(self.balance)")
            } else {
                print("Insufficient funds for withdrawal of \(amount)")
            }
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



