import XCTest
import UIKit
@testable import Auk

class AukInterfaceScrollToTests: XCTestCase {
  
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
  
  // MARK: - Scroll to offset
  
  func testScrollTo() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.scrollToPage(atIndex: 2, animated: false)
    XCTAssertEqual(240, scrollView.contentOffset.x)
  }
  
  func testScrollTo_noPages() {
    auk.scrollToPage(atIndex: 0, animated: false)
    XCTAssertEqual(0, scrollView.contentOffset.x)
  }
  
  func testScrollTo_preventOverscrollingToTheRight() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.scrollToPage(atIndex: 3, animated: false)
    XCTAssertEqual(240, scrollView.contentOffset.x)
  }
  
  func testScrollTo_preventOverscrollingToTheLeft() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.scrollToPage(atIndex: -1, animated: false)
    XCTAssertEqual(0, scrollView.contentOffset.x)
  }
  
  // MARK: - Scroll to offset with width
  
  func testScrollToWithWidth() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.scrollToPage(atIndex: 2, pageWidth: 128, animated: false)
    XCTAssertEqual(256, scrollView.contentOffset.x)
  }
}
