import XCTest
import UIKit

class AukInterfaceCurrentPageIndexTestsTests: XCTestCase {
  
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
  
  func testCurrentPageIndex() {
    // Show 2 images
    // -------------
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    XCTAssertEqual(0, auk.currentPageIndex)
    
    // Scroll to show more than the half of the second page
    scrollView.contentOffset.x = 70
    
    XCTAssertEqual(1, auk.currentPageIndex)
    
    // Scroll to the second image
    scrollView.contentOffset.x = 120
    
    XCTAssertEqual(1, auk.currentPageIndex)
    
    // Scroll to show the third page ALMOST entirely
    scrollView.contentOffset.x = 230
    
    XCTAssertEqual(2, auk.currentPageIndex)
  }
}