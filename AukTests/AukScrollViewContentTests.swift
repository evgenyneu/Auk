import UIKit
import XCTest
@testable import Auk

class AukScrollViewContentTests: XCTestCase {
  
  var scrollView: UIScrollView!
  let settings = AukSettings()
  var fakeAnimator: iiFakeAnimator!

  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Use fake animator
    fakeAnimator = iiFakeAnimator()
    iiAnimator.currentAnimator = fakeAnimator
  }
  
  override func tearDown() {
    super.tearDown()
    
    iiAnimator.currentAnimator = nil // Remove the fake animator
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
  
  // MARK: - Layout
  // -----------------
  
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
  
  func testLayout_callCompletionFunction() {    
    var didCallCompletion = false
    
    AukScrollViewContent.layout(scrollView, animated: false, animationDurationInSeconds: 0, completion: {
      didCallCompletion = true
    })
    
    assert(didCallCompletion)
  }
  
  func testLayout_animated() {
    scrollView.bounds.size = CGSize(width: 180, height: 120)
    let aukView1 = AukPage()
    let aukView2 = AukPage()
    let aukView3 = AukPage()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    scrollView.addSubview(aukView3)
    
    var didCallCompletion = false

    AukScrollViewContent.layout(scrollView, animated: true, animationDurationInSeconds: 120, completion: {
        didCallCompletion = true
      }
    )
    
    XCTAssertEqual(1, fakeAnimator.testParameters.count)
    XCTAssertEqual(120, fakeAnimator.testParameters[0].duration)
    
    // Animation
    XCTAssertEqual(CGSize(width: 0, height: 0), scrollView.contentSize)
    fakeAnimator.testParameters[0].animation()
    XCTAssertEqual(CGSize(width: 540, height: 120), scrollView.contentSize)
    
    // Completion
    XCTAssertFalse(didCallCompletion)
    fakeAnimator.testParameters[0].completion?(true)
    XCTAssert(didCallCompletion)
  }
  
  // MARK: - PageAt
  // -----------------
  
  func testPageAt() {
    let aukView1 = AukPage()
    let aukView2 = AukPage()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    var result = AukScrollViewContent.page(atIndex: 0, scrollView: scrollView)
    XCTAssert(result === aukView1)
    
    result = AukScrollViewContent.page(atIndex: 1, scrollView: scrollView)
    XCTAssert(result === aukView2)
  }
  
  func testPageAt_noPages() {
    let result = AukScrollViewContent.page(atIndex: 0, scrollView: scrollView)
    XCTAssertNil(result)
  }
  
  func testPageAt_indexGreaterThanExist() {
    let aukView1 = AukPage()
    let aukView2 = AukPage()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    let result = AukScrollViewContent.page(atIndex: 2, scrollView: scrollView)
    XCTAssertNil(result)
  }
  
  func testPageAt_indexLessThanExist() {
    let aukView1 = AukPage()
    let aukView2 = AukPage()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    let result = AukScrollViewContent.page(atIndex: -1, scrollView: scrollView)
    XCTAssertNil(result)
  }

}
