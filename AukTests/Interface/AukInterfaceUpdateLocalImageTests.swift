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
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    let image67px = uiImageFromFile("67px.png")
    auk.updateAt(0, image: image67px)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(67, firstAukImage(scrollView, pageIndex: 0)!.size.width)
  }
  
  func testUpdateLocalImage_indexLargerThanExist() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    let image67px = uiImageFromFile("67px.png")
    auk.updateAt(1, image: image67px)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(96, firstAukImage(scrollView, pageIndex: 0)!.size.width)
  }
  
  func testUpdateLocalImage_indexNegative() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    let image67px = uiImageFromFile("67px.png")
    auk.updateAt(-1, image: image67px)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(96, firstAukImage(scrollView, pageIndex: 0)!.size.width)
  }
  
  func testUpdateLocalImage_noImages() {
    let image67px = uiImageFromFile("67px.png")
    auk.updateAt(0, image: image67px)
    XCTAssertEqual(0, aukPages(scrollView).count)
  }
  
  // MARK: - Accessibility
  
  func testUpdateAccessiblePageView_withLabel() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image, accessibilityLabel: "Penguin")
    
    let image67px = uiImageFromFile("67px.png")
    auk.updateAt(0, image: image67px, accessibilityLabel: "White knight riding a wooden horse on wheels.")
    
    let page = aukPage(scrollView, pageIndex: 0)!
    
    XCTAssert(page.isAccessibilityElement)
    XCTAssertEqual(page.accessibilityTraits, UIAccessibilityTraitImage)
    XCTAssertEqual("White knight riding a wooden horse on wheels.", page.accessibilityLabel!)
  }
  
  func testUpdateAccessiblePageView_removeExistingLabel() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image, accessibilityLabel: "Penguin")
    
    let image67px = uiImageFromFile("67px.png")
    auk.updateAt(0, image: image67px)
    
    let page = aukPage(scrollView, pageIndex: 0)!
    
    XCTAssert(page.isAccessibilityElement)
    XCTAssertEqual(page.accessibilityTraits, UIAccessibilityTraitImage)
    XCTAssert(page.accessibilityLabel == nil)
  }
}