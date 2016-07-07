import XCTest
import UIKit
@testable import Auk

class AukInterfaceCurrentPageIndexTestsTests: XCTestCase {
  
  var scrollView: UIScrollView!
  var auk: Auk!
  
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
    
    let image = createImage96px()
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
  
  func testCurrentPageIndex_indexOutOfBounds() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    
    // Scrolled to the right over the rightmost image
    
    scrollView.contentOffset.x = 180
    XCTAssertEqual(1, auk.currentPageIndex)
    
    scrollView.contentOffset.x = 1800
    XCTAssertEqual(1, auk.currentPageIndex)
    
    // Scrolled to the left over the leftmost image
    scrollView.contentOffset.x = -70
    XCTAssertEqual(0, auk.currentPageIndex)
  }
  
  func testCurrentPageIndex_noImages() {
    XCTAssertNil(auk.currentPageIndex)
  }
  
  func testCurrenPageIndex_rightToLeft() {
    if #available(iOS 9.0, *) {
      scrollView.semanticContentAttribute = .forceRightToLeft
     
      // Show 2 images
      // -------------
      
      let image = createImage96px()
      auk.show(image: image)
      auk.show(image: image)
      auk.show(image: image)
      
      // Show first page by default
      XCTAssertEqual(0, auk.currentPageIndex)
      
      // Scroll to third page explicitely
      scrollView.contentOffset.x = 240
      XCTAssertEqual(0, auk.currentPageIndex)
      
      // Scroll to show more than the half of the second page
      scrollView.contentOffset.x = 140
      XCTAssertEqual(1, auk.currentPageIndex)
      
      // Scroll to the second image
      scrollView.contentOffset.x = 120
      XCTAssertEqual(1, auk.currentPageIndex)
      
      // Scroll to show the third page ALMOST entirely
      scrollView.contentOffset.x = 20
      XCTAssertEqual(2, auk.currentPageIndex)
    }
  }
  
  func testCurrentPageIndex_handleZeroWidth() {
    scrollView.bounds = CGRect(origin: CGPoint(), size: CGSize())
    
    let image = createImage96px()
    auk.show(image: image)
    
    XCTAssertNil(auk.currentPageIndex)
  }
}
