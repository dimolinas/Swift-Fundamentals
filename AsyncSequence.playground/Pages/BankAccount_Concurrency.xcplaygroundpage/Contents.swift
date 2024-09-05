import UIKit

class BankAccount {
    var balance: Double
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func withdraw(_ amount: Double) {
        if balance >= amount {
            let processingTime = UInt32.random(in: 0...3)
            print("[Withdraw] Processing for \(amount) \(processingTime) seconds")
            sleep(processingTime)
            print("Withdraw \(amount) from account")
            balance -= amount
            print("Balance is \(balance)")
        }
    }
}


let bankAccount = BankAccount(balance: 500)

let queue = DispatchQueue(label: "SerialQueue", attributes: .serial)

queue.async {
    bankAccount.withdraw(300)
}

queue.async {
    bankAccount.withdraw(500)
}

