import XCTest
import UIKit
@testable import Auk

class AukInterfaceShowLocalImageTests: XCTestCase {
  
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
  
  func testSetupIsCalled() {
    let image = createImage96px()
    auk.show(image: image)
    
    XCTAssertFalse(scrollView.showsHorizontalScrollIndicator)
  }
  
  func testShowLocalImage() {
    let image = createImage96px()
    auk.show(image: image)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 0))
  }
  
  func testShowLocalImage_layoutSubviews() {
    let image1 = createImage96px()
    auk.show(image: image1)
    
    let image2 = createImage67px()
    auk.show(image: image2)
    
    scrollView.layoutIfNeeded()
    
    // Check content size
    // -------------
    
    XCTAssertEqual(CGSize(width: 240, height: 90), scrollView.contentSize)
    
    // View 1
    // -------------
    
    let aukView1 = aukPages(scrollView)[0]
    XCTAssertEqual(CGPoint(x: 0, y: 0), aukView1.frame.origin)
    XCTAssertEqual(CGSize(width: 120, height: 90), aukView1.frame.size)
    
    // View 2
    // -------------
    
    let aukView2 = aukPages(scrollView)[1]
    XCTAssertEqual(CGPoint(x: 120, y: 0), aukView2.frame.origin)
    XCTAssertEqual(CGSize(width: 120, height: 90), aukView2.frame.size)
  }
  
  func testShowLocalImage_layoutSubviews_rightToLeft() {
    if #available(iOS 9.0, *) {
      scrollView.semanticContentAttribute = .forceRightToLeft
      
      let image1 = createImage96px()
      auk.show(image: image1)
      
      let image2 = createImage67px()
      auk.show(image: image2)
      
      scrollView.layoutIfNeeded()
      
      // Check content size
      // -------------
      
      XCTAssertEqual(CGSize(width: 240, height: 90), scrollView.contentSize)
      
      // View 1
      // -------------
      
      let aukView1 = aukPages(scrollView)[0]
      XCTAssertEqual(CGPoint(x: 120, y: 0), aukView1.frame.origin)
      XCTAssertEqual(CGSize(width: 120, height: 90), aukView1.frame.size)
      XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 0))
      
      // View 2
      // -------------
      
      let aukView2 = aukPages(scrollView)[1]
      XCTAssertEqual(CGPoint(x: 0, y: 0), aukView2.frame.origin)
      XCTAssertEqual(CGSize(width: 120, height: 90), aukView2.frame.size)
      XCTAssertEqual(67, firstAukImageWidth(scrollView, pageIndex: 1))
      
    }
  }
  
  func testShowLocalImage_contentOffset() {
    XCTAssertEqual(0, scrollView.contentOffset.x)
    
    let image1 = createImage96px()
    auk.show(image: image1)
    
    XCTAssertEqual(0, scrollView.contentOffset.x)
    
    let image2 = createImage67px()
    auk.show(image: image2)
    
    XCTAssertEqual(0, scrollView.contentOffset.x)
  }
  
  func testShowLocalImage_contentOffset_rightToLeft() {
    if #available(iOS 9.0, *) {
      scrollView.semanticContentAttribute = .forceRightToLeft
      
      XCTAssertEqual(0, scrollView.contentOffset.x)
      
      let image1 = createImage96px()
      auk.show(image: image1)
      XCTAssertEqual(0, scrollView.contentOffset.x)
      
      let image2 = createImage67px()
      auk.show(image: image2)
      XCTAssertEqual(120, scrollView.contentOffset.x)
      
      let image3 = createImage35px()
      auk.show(image: image3)
      XCTAssertEqual(240, scrollView.contentOffset.x)
    }
  }
  
  // MARK: - Accessibility
  
  func testCreateAccessiblePageView_withLabel() {
    let image = createImage96px()
    auk.show(image: image, accessibilityLabel: "White knight riding a wooden horse on wheels.")
    
    let page = aukPage(scrollView, pageIndex: 0)!
    
    XCTAssert(page.isAccessibilityElement)
    XCTAssertEqual(page.accessibilityTraits, UIAccessibilityTraits.image)
    XCTAssertEqual("White knight riding a wooden horse on wheels.", page.accessibilityLabel!)
  }
  
  func testCreateAccessiblePageView_withoutLabel() {
    let image = createImage96px()
    auk.show(image: image)
    
    let page = aukPage(scrollView, pageIndex: 0)!
    
    XCTAssert(page.isAccessibilityElement)
    XCTAssertEqual(page.accessibilityTraits, UIAccessibilityTraits.image)
    XCTAssert(page.accessibilityLabel == nil)
  }
}
