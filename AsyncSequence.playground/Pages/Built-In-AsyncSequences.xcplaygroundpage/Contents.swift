import Foundation
import UIKit
import _Concurrency

let paths = Bundle.main.paths(forResourcesOfType: "txt", inDirectory: nil)
let fileHandle = FileHandle(forReadingAtPath: paths[0])!

Task {
    for try await line in fileHandle.bytes {
     print(line)
    }
}

let fileSize = try fileHandle.seekToEnd()
try fileHandle.seek(toOffset: 0)

let queue = DispatchQueue(label:"com.AsyncSequence", attributes: .concurrent)
let group = DispatchGroup()

for offset in stride(from: 0, to: fileSize, by: 1024) {
    group.enter()
    queue.async {
        do {
            try fileHandle.seek(toOffset: offset)
            let chunkData = fileHandle.readData(ofLength: 1024)
            if let chunkString = String(data: chunkData, encoding: .utf8) {
                print("Chunk at offset \(offset): \(chunkString)")
            }
        }
        catch{
            print("error: ",error)
        }
    }
    group.leave()
}



