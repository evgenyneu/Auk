import UIKit
import XCTest
import moa

class AukPageVisibilityTests: XCTestCase {
  var scrollView: UIScrollView!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 290, height: 200)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
  }
  
  // MARK: - Is page visible
  
  func testIsVisible_firstPageVisible() {
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()

    XCTAssert(AukPageVisibility.isVisible(scrollView, page: aukPage1))
    XCTAssertFalse(AukPageVisibility.isVisible(scrollView, page: aukPage2))
  }

  func testIsVisible_bothPagesAreVisible() {
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()
    
    scrollView.contentOffset.x = 289

    XCTAssert(AukPageVisibility.isVisible(scrollView, page: aukPage1))
    XCTAssert(AukPageVisibility.isVisible(scrollView, page: aukPage2))
  }

  func testIsPageVisible_lastPageVisible() {
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()
    
    scrollView.contentOffset.x = 290
    
    XCTAssertFalse(AukPageVisibility.isVisible(scrollView, page: aukPage1))
    XCTAssert(AukPageVisibility.isVisible(scrollView, page: aukPage2))
  }
}