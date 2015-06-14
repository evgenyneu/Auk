import UIKit
import XCTest

class AukScrollViewContentTests: XCTestCase {
  
  var scrollView: UIScrollView!

  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 100, height: 75)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
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
    let aukView1 = AukView()
    let aukView2 = AukView()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)

    AukScrollViewContent.updateContentSize(scrollView)
    
    XCTAssertEqual(CGSize(width: 200, height: 75), scrollView.contentSize)
  }
  
  func testPositionSingleSubview() {
    let aukView = AukView()
    let origin = CGPoint(x: 200, y: 0)
    
    AukScrollViewContent.positionSingleSubview(scrollView, subview: aukView, origin: origin)
    
    XCTAssertEqual(CGPoint(x: 200, y: 0), aukView.frame.origin)
    XCTAssertEqual(CGSize(width: 100, height: 75), aukView.frame.size)
  }
  
  func testPositionSubviews() {
    let aukView1 = AukView()
    let aukView2 = AukView()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    AukScrollViewContent.positionSubviews(scrollView)
    
    // View 1
    // -------------
    
    XCTAssertEqual(CGPoint(x: 0, y: 0), aukView1.frame.origin)
    XCTAssertEqual(CGSize(width: 100, height: 75), aukView1.frame.size)
    
    // View 2
    // -------------
    
    XCTAssertEqual(CGPoint(x: 100, y: 0), aukView2.frame.origin)
    XCTAssertEqual(CGSize(width: 100, height: 75), aukView2.frame.size)
  }
  
  func testLayout() {
    let aukView1 = AukView()
    let aukView2 = AukView()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    AukScrollViewContent.layout(scrollView)
    
    // Check content size
    // -------------

    XCTAssertEqual(CGSize(width: 200, height: 75), scrollView.contentSize)
    
    // View 1
    // -------------
    
    XCTAssertEqual(CGPoint(x: 0, y: 0), aukView1.frame.origin)
    XCTAssertEqual(CGSize(width: 100, height: 75), aukView1.frame.size)
    
    // View 2
    // -------------
    
    XCTAssertEqual(CGPoint(x: 100, y: 0), aukView2.frame.origin)
    XCTAssertEqual(CGSize(width: 100, height: 75), aukView2.frame.size)
  }
}
