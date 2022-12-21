import XCTest
@testable import SnapshotTests

final class SnapshotTestsTests: XCTestCase {
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
