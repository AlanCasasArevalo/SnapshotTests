import XCTest
@testable import SnapshotTests

final class SnapshotTestsTests: XCTestCase {
    func test_zer() {
        let (sut) = makeSUT()
        
        record(snapshot: sut.snapshot(), named: "DEFAULT_INITIAL_SCREEN")
    }
}

extension SnapshotTestsTests {
    // MARK: - Helper
    func makeSUT () -> (ViewController) {
        let bundle = Bundle(for: ViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        
        sut.loadViewIfNeeded()
        
        return (sut)
    }
    
    func record(snapshot: UIImage, named name: String, file: StaticString = #filePath, line: UInt = #line) {
        guard let snapshotData = snapshot.pngData() else {
            XCTFail("Failed to generate PNG data representation from snapshot", file: file, line: line)
            return
        }

        let snapshotURL = URL(fileURLWithPath: String(describing: file))
            .deletingLastPathComponent()
            .appendingPathComponent("snapshots")
            .appendingPathComponent("\(name).png")

        do {
            try FileManager.default.createDirectory(
                at: snapshotURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )

            try snapshotData.write(to: snapshotURL)
        } catch {
            XCTFail("Failed to record snapshot with error: \(error)", file: file, line: line)
        }
    }
}

extension UIViewController {
    func snapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { action in
            view.layer.render(in: action.cgContext)
        }
    }
}
