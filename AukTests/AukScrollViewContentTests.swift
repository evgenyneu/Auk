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
  
  
  func testLayout() {
    scrollView.bounds.size = CGSize(width: 180, height: 120)
    
    let aukView1 = AukView()
    let aukView2 = AukView()
    let aukView3 = AukView()

    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    scrollView.addSubview(aukView3)
    
    AukScrollViewContent.layout(scrollView)
    
    scrollView.layoutIfNeeded()
    
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
    
    // View 3
    // -------------
    
    XCTAssertEqual(CGPoint(x: 360, y: 0), aukView3.frame.origin)
    XCTAssertEqual(CGSize(width: 180, height: 120), aukView3.frame.size)
  }
}
