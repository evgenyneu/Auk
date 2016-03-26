import UIKit
import XCTest
@testable import Auk

class AukScrollViewContentTests: XCTestCase {
  
  var scrollView: UIScrollView!
  let settings = AukSettings()

  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
  }
  
  func testAukPages() {
    let aukView1 = AukPage()
    let aukView2 = AukPage()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    let pages = AukScrollViewContent.aukPages(scrollView)
    
    XCTAssertEqual(2, pages.count)
    XCTAssert(pages[0] === aukView1)
    XCTAssert(pages[1] === aukView2)
  }
  
  func testLayout() {
    scrollView.bounds.size = CGSize(width: 180, height: 120)
    
    let aukView1 = AukPage()
    let aukView2 = AukPage()
    let aukView3 = AukPage()

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
  
  // MARK: - PageAt
  // -----------------
  
  func testPageAt() {
    let aukView1 = AukPage()
    let aukView2 = AukPage()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    var result = AukScrollViewContent.pageAt(0, scrollView: scrollView)
    XCTAssert(result === aukView1)
    
    result = AukScrollViewContent.pageAt(1, scrollView: scrollView)
    XCTAssert(result === aukView2)
  }
  
  func testPageAt_noPages() {
    let result = AukScrollViewContent.pageAt(0, scrollView: scrollView)
    XCTAssertNil(result)
  }
  
  func testPageAt_indexGreaterThanExist() {
    let aukView1 = AukPage()
    let aukView2 = AukPage()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    let result = AukScrollViewContent.pageAt(2, scrollView: scrollView)
    XCTAssertNil(result)
  }
  
  func testPageAt_indexLessThanExist() {
    let aukView1 = AukPage()
    let aukView2 = AukPage()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    let result = AukScrollViewContent.pageAt(-1, scrollView: scrollView)
    XCTAssertNil(result)
  }

}
