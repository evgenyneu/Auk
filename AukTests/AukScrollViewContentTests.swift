import UIKit
import XCTest

class AukScrollViewContentTests: XCTestCase {
  
  var scrollView: UIScrollView!
  let settings = AukSettings()

  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
  }
  
  func testAukViews() {
    let aukView1 = AukView()
    let aukView2 = AukView()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    let views = AukScrollViewContent.aukViews(scrollView)
    
    XCTAssertEqual(2, views.count)
    XCTAssert(views[0] === aukView1)
    XCTAssert(views[1] === aukView2)
  }
  
  func testUpdateContentSize() {
    let size = CGSize(width: 180, height: 120)
    let aukView1 = AukView()
    let aukView2 = AukView()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)

    AukScrollViewContent.updateContentSize(scrollView, size: size)
    
    XCTAssertEqual(CGSize(width: 360, height: 120), scrollView.contentSize)
  }
  
  func testPositionSingleSubview() {
    let size = CGSize(width: 180, height: 120)

    let aukView = AukView()
    let origin = CGPoint(x: 200, y: 0)
    
    AukScrollViewContent.positionSingleSubview(scrollView, subview: aukView,
      origin: origin, size: size)
    
    XCTAssertEqual(CGPoint(x: 200, y: 0), aukView.frame.origin)
    XCTAssertEqual(CGSize(width: 180, height: 120), aukView.frame.size)
  }
  
  func testPositionSubviews() {
    let size = CGSize(width: 180, height: 120)

    let aukView1 = AukView()
    let aukView2 = AukView()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    AukScrollViewContent.positionSubviews(scrollView, size: size)
    
    // View 1
    // -------------
    
    XCTAssertEqual(CGPoint(x: 0, y: 0), aukView1.frame.origin)
    XCTAssertEqual(CGSize(width: 180, height: 120), aukView1.frame.size)
    
    // View 2
    // -------------
    
    XCTAssertEqual(CGPoint(x: 180, y: 0), aukView2.frame.origin)
    XCTAssertEqual(CGSize(width: 180, height: 120), aukView2.frame.size)
  }
  
  func testLayout() {
    let size = CGSize(width: 180, height: 120)

    let aukView1 = AukView()
    let aukView2 = AukView()
    let aukView3 = AukView()

    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    scrollView.addSubview(aukView3)
    
    AukScrollViewContent.layout(scrollView, size: size, pageIndex: 1)
    
    // Check content size
    // -------------

    XCTAssertEqual(CGSize(width: 540, height: 120), scrollView.contentSize)
    
    // View 1
    // -------------
    
    XCTAssertEqual(CGPoint(x: 0, y: 0), aukView1.frame.origin)
    XCTAssertEqual(CGSize(width: 180, height: 120), aukView1.frame.size)
    
    // View 2
    // -------------
    
    XCTAssertEqual(CGPoint(x: 180, y: 0), aukView2.frame.origin)
    XCTAssertEqual(CGSize(width: 180, height: 120), aukView2.frame.size)
    
    // Check content offset
    // -------------

    XCTAssertEqual(CGPoint(x: 180, y: 0), scrollView.contentOffset)
  }
  
  // MARK: - Hide all views except current
  
  func testHideAllViewsExceptCurrent() {
    let aukView1 = AukView()
    let aukView2 = AukView()
    let aukView3 = AukView()

    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    scrollView.addSubview(aukView3)

    AukScrollViewContent.hideAllViewsExceptCurrent(scrollView, pageIndex: 1)
    
    XCTAssert(aukView1.hidden)
    XCTAssertFalse(aukView2.hidden)
    XCTAssert(aukView3.hidden)
  }
}
