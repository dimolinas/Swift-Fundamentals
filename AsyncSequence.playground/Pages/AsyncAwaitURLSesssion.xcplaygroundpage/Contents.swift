import UIKit

struct Lines: Sequence {
    let url: URL
    
    func makeIterator() -> some IteratorProtocol {
        let lines = (try? String(contentsOf: url))?.split(separator: "\n") ?? []
        return LinesIterator(lines: lines)
    }
}

struct LinesIterator: IteratorProtocol {
    
    typealias Element = String
    var lines: [String.SubSequence]
    
    mutating func next() -> Element? {
        if lines.isEmpty {
            return nil
        }
        return String(lines.removeFirst())
    }
}

extension URL {
    func allLines() async -> Lines {
        Lines(url: self)
    }
}

let endPointURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv")!

//wait all the items
Task {
    for line in await endPointURL.allLines(){
        print(line)
    }
}


//line by line
Task {
    for try await line in endPointURL.lines {
        print(line)
    }
}




