import UIKit
import XCTest

enum FecthError: Error {
    case baidID
    case badURL
    case badImage
}

extension UIImage {
    var thumbnail: UIImage? {
        get async {
            let size = CGSize(width: 40, height: 40)
            return await self.byPreparingThumbnail(ofSize: size)
        }
    }
}

func fecthThumbnails(for id: String) async throws-> [UIImage] {
    guard let url = URL(string: id) else { throw FecthError.badURL}
    let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
    guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FecthError.baidID }
    let maybeImage = UIImage(data: data)
    guard let thumbnail = await maybeImage?.thumbnail else { throw FecthError.badImage}
    return [thumbnail]
}


func updateUI() async -> Void {
    do {
        let thumbnails = try await fecthThumbnails(for: "Image")
        Task.detached(priority: .background ) {
            writeToCache(images: thumbnails)
        }
    }catch {
        print("some error")
    }
}


private func writeToCache(images: [UIImage]) -> Void {
    //Write cache
}

Task {
    await updateUI()
}


class MockViewMOdelSpec: XCTestCase {
    func testFetchThumbnails() async throws {
        let result = try await fecthThumbnails(for: "id")
        XCTAssertEqual(result[0].size, CGSize(width: 40, height: 40))
    }
}

