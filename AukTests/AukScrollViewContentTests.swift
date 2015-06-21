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

    AukScrollViewContent.updateContentSize(scrollView, pageSize: size)
    
    XCTAssertEqual(CGSize(width: 360, height: 120), scrollView.contentSize)
  }
  
  func testPositionSingleSubview() {
    let size = CGSize(width: 180, height: 120)

    let aukView = AukView()
    let origin = CGPoint(x: 200, y: 0)
    
    AukScrollViewContent.positionSingleSubview(scrollView, subview: aukView,
      origin: origin, pageSize: size)
    
    XCTAssertEqual(CGPoint(x: 200, y: 0), aukView.frame.origin)
    XCTAssertEqual(CGSize(width: 180, height: 120), aukView.frame.size)
  }
  
  func testPositionSubviews() {
    let size = CGSize(width: 180, height: 120)

    let aukView1 = AukView()
    let aukView2 = AukView()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    AukScrollViewContent.positionSubviews(scrollView, pageSize: size)
    
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
    
    AukScrollViewContent.layout(scrollView, pageSize: size, pageIndex: 1)
    
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
  
  // MARK: - Hide all views except one
  
  func testHideAllViewsExceptOne() {
    let aukView1 = AukView()
    let aukView2 = AukView()
    let aukView3 = AukView()

    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    scrollView.addSubview(aukView3)

    AukScrollViewContent.hideAllViewsExceptOne(scrollView, pageIndex: 1)
    
    XCTAssert(aukView1.hidden)
    XCTAssertFalse(aukView2.hidden)
    XCTAssert(aukView3.hidden)
  }
  
  // MARK: - Show all views
  
  func testShowViews() {
    let aukView1 = AukView()
    let aukView2 = AukView()
    let aukView3 = AukView()
    
    aukView1.hidden = true
    aukView2.hidden = true
    aukView3.hidden = true
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    scrollView.addSubview(aukView3)
    
    AukScrollViewContent.showViews(scrollView)
    
    XCTAssertFalse(aukView1.hidden)
    XCTAssertFalse(aukView2.hidden)
    XCTAssertFalse(aukView3.hidden)
  }
}
