import UIKit
import XCTest

class AukTests: XCTestCase {
  
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
  
  // MARK: - Setup
  
  func testSetup_doNotShowScrollIndicator() {
    auk = Auk(scrollView: scrollView)
    auk.setup()
    
    XCTAssertFalse(scrollView.showsHorizontalScrollIndicator)
    XCTAssert(scrollView.pagingEnabled)
  }
  
  // MARK: - Show local image
  
  func testSetupIsCalled() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    XCTAssertFalse(scrollView.showsHorizontalScrollIndicator)
  }
  
  func testShowLocalImage() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(96, firstAukImage(scrollView, index: 0)!.size.width)
  }
  
  func testShowLocalImage_layoutSubviews() {
    let image1 = uiImageFromFile("96px.png")
    auk.show(image: image1)
    
    let image2 = uiImageFromFile("67px.png")
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
  
  // MARK: - Show remote image
  
  func testShowRemoteImage_setupIsCalled() {
    auk.show(url: "http://site.com/image.png")
    
    XCTAssertFalse(scrollView.showsHorizontalScrollIndicator)
  }
  
  func testShowRemoteImage() {
    auk.show(url: "http://site.com/image1.png")
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(96, firstAukImage(scrollView, index: 0)!.size.width)
  }
  
  func testShowRemoteImage_layoutSubviews() {
    auk.show(url: "http://site.com/image1.png")
    auk.show(url: "http://site.com/image2.png")
    
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
}
