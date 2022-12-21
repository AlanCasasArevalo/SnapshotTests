import XCTest
@testable import SnapshotTests

final class SnapshotTestsTests: XCTestCase {
    func test_zer() {
        let (sut) = makeSUT()
        
        let snapshot = sut.snapshot()
    }
}

extension SnapshotTestsTests {
    // MARK: - Helper
    func makeSUT () -> (ViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        
        sut.loadViewIfNeeded()
        
        return (sut)
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
