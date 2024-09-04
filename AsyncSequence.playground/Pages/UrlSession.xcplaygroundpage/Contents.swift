import Foundation
import UIKit

let url = URL(string: "https://www.google.com")!

Task{
    print("Starting Task 1")
    let (bytes, _) = try await URLSession.shared.bytes(from: url)
    for try await byte in bytes {
        print(byte)
    }
}


Task{
    print("Starting Task 2")
    let center = NotificationCenter.default
    await center.notifications(named: UIApplication.didEnterBackgroundNotification).first {
        guard let key = ($0.userInfo?["Key"]) as? String else { return false }
        return key == "Some Value"
    }
}


