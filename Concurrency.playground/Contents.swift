import UIKit

let queue = DispatchQueue(label: "SerialQueue")

queue.async {
    for i in 1...10{
        print(i)
    }
}

queue.async {
    for i in 1...20{
        print(i)
    }
}


let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)

concurrentQueue.async {
    for i in 1...10{
        print(i, "one")
    }
}

concurrentQueue.async {
    for i in 1...10{
        print(i,"two")
    }
}


DispatchQueue.global().async {
    //download the image
    DispatchQueue.main.async{
        //refresh ui
    }
}
