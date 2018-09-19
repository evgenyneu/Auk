import XCTest
import UIKit
@testable import Auk

class AukInterfaceUpdateLocalImageTests: XCTestCase {
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
  
  func testUpdateLocalImage() {
    let image = createImage96px()
    auk.show(image: image)
    
    let image67px = createImage67px()
    auk.updatePage(atIndex: 0, image: image67px)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(67, firstAukImageWidth(scrollView, pageIndex: 0))
  }
  
  func testUpdateLocalImage_updateOnlyGivenSingePage() {
    // Show two images
    let image96px = createImage96px()
    auk.show(image: image96px)
    
    let image35px = createImage35px()
    auk.show(image: image35px)
    
    // Update image on the second page
    let image67px = createImage67px()
    auk.updatePage(atIndex: 1, image: image67px)
    
    XCTAssertEqual(2, aukPages(scrollView).count)
    
    // First page images remains unchanged
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 0))

    // Second page image is updated
    XCTAssertEqual(67, firstAukImageWidth(scrollView, pageIndex: 1))
  }
  
  func testUpdateLocalImage_indexLargerThanExist() {
    let image = createImage96px()
    auk.show(image: image)
    
    let image67px = createImage67px()
    auk.updatePage(atIndex: 1, image: image67px)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 0))
  }
  
  func testUpdateLocalImage_indexNegative() {
    let image = createImage96px()
    auk.show(image: image)
    
    let image67px = createImage67px()
    auk.updatePage(atIndex: -1, image: image67px)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 0))
  }
  
  func testUpdateLocalImage_noImages() {
    let image67px = createImage67px()
    auk.updatePage(atIndex: 0, image: image67px)
    XCTAssertEqual(0, aukPages(scrollView).count)
  }
  
  // MARK: - Accessibility
  
  func testUpdateAccessiblePageView_withLabel() {
    let image = createImage96px()
    auk.show(image: image, accessibilityLabel: "Penguin")
    
    let image67px = createImage67px()
    auk.updatePage(atIndex: 0, image: image67px, accessibilityLabel: "White knight riding a wooden horse on wheels.")
    
    let page = aukPage(scrollView, pageIndex: 0)!
    
    XCTAssert(page.isAccessibilityElement)
    XCTAssertEqual(page.accessibilityTraits, UIAccessibilityTraits.image)
    XCTAssertEqual("White knight riding a wooden horse on wheels.", page.accessibilityLabel!)
  }
  
  func testUpdateAccessiblePageView_removeExistingLabel() {
    let image = createImage96px()
    auk.show(image: image, accessibilityLabel: "Penguin")
    
    let image67px = createImage67px()
    auk.updatePage(atIndex: 0, image: image67px)
    
    let page = aukPage(scrollView, pageIndex: 0)!
    
    XCTAssert(page.isAccessibilityElement)
    XCTAssertEqual(page.accessibilityTraits, UIAccessibilityTraits.image)
    XCTAssert(page.accessibilityLabel == nil)
  }
}
