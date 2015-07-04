import UIKit
import XCTest
import moa

class AukScrollNextPreviousPageTests: XCTestCase {
  
  var scrollView: UIScrollView!
  var auk: AukInterface!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 120, height: 90)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
    
    auk = Auk(scrollView: scrollView)
  }
  
  // MARK: - Scroll to next page
  
  func testScrollToNextPage() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.scrollToNextPage()
    XCTAssertEqual(1, auk.currentPageIndex)
    
    auk.scrollToNextPage()
    XCTAssertEqual(2, auk.currentPageIndex)
    
    auk.scrollToNextPage()
    XCTAssertEqual(0, auk.currentPageIndex)
  }
}