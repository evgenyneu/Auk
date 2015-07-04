import XCTest
import UIKit

class AukInterfaceStartAutoScrollTests: XCTestCase {
  
  var scrollView: UIScrollView!
  var auk: AukInterface!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 120, height: 90)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
    
    auk = Auk(scrollView: scrollView)
  }
  
  
  // MARK: - Start auto scroll
  
  func testStartAutoScroll_toPage1() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)

    auk.startAutoScroll(delaySeconds: 0.1)

    
    // Scroll to page 1
    // -------------
    let expectation = expectationWithDescription("scroll")
    iiQ.runAfterDelay(0.15) { expectation.fulfill() }
    waitForExpectationsWithTimeout(1) { _ in }
    XCTAssertEqual(1, auk.currentPageIndex)
  }
  
  func testStartAutoScroll_toPage2() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.1)
    
    // Scroll to page 2
    // -------------
    let expectation = expectationWithDescription("scroll")
    iiQ.runAfterDelay(0.25) { expectation.fulfill() }
    waitForExpectationsWithTimeout(1) { _ in }
    XCTAssertEqual(2, auk.currentPageIndex)
  }
  
  func testStartAutoScroll_cycleToPag0() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.1)
    
    // Scroll to page 2
    // -------------
    let expectation = expectationWithDescription("scroll")
    iiQ.runAfterDelay(0.35) { expectation.fulfill() }
    waitForExpectationsWithTimeout(1) { _ in }
    XCTAssertEqual(0, auk.currentPageIndex)
  }
  
  // MARK: - With parameters, forward
  
  func testStartAutoScroll_withParameters_forward_toPage1() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.1, forward: true, cycle: true, animated: false)
    
    // Scroll to page 1
    // -------------
    let expectation = expectationWithDescription("scroll")
    iiQ.runAfterDelay(0.15) { expectation.fulfill() }
    waitForExpectationsWithTimeout(1) { _ in }
    XCTAssertEqual(1, auk.currentPageIndex)
  }
  
  func testStartAutoScroll_withParameters_backwards_toPage2() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.1, forward: false, cycle: true, animated: false)
    
    // Scroll to page 1
    // -------------
    let expectation = expectationWithDescription("scroll")
    iiQ.runAfterDelay(0.15) { expectation.fulfill() }
    waitForExpectationsWithTimeout(1) { _ in }
    XCTAssertEqual(2, auk.currentPageIndex)
  }
  
  // MARK: - With parameters, forward, cycle
  
  func testStartAutoScroll_withParameters_forward_cycle_toPage1() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.1, forward: true, cycle: true, animated: false)
    
    // Scroll to page 1
    // -------------
    let expectation = expectationWithDescription("scroll")
    iiQ.runAfterDelay(0.35) { expectation.fulfill() }
    waitForExpectationsWithTimeout(1) { _ in }
    XCTAssertEqual(0, auk.currentPageIndex)
  }
  
  func testStartAutoScroll_withParameters_forward_noCycle_toPage1() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.1, forward: true, cycle: false, animated: false)
    
    // Scroll to page 1
    // -------------
    let expectation = expectationWithDescription("scroll")
    iiQ.runAfterDelay(0.35) { expectation.fulfill() }
    waitForExpectationsWithTimeout(1) { _ in }
    XCTAssertEqual(2, auk.currentPageIndex)
  }
  
  // MARK: - With parameters, backwards, cycle
  
  func testStartAutoScroll_withParameters_backwards_cycle_toPage1() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.1, forward: false, cycle: true, animated: false)
    
    // Scroll to page 1
    // -------------
    let expectation = expectationWithDescription("scroll")
    iiQ.runAfterDelay(0.15) { expectation.fulfill() }
    waitForExpectationsWithTimeout(1) { _ in }
    XCTAssertEqual(2, auk.currentPageIndex)
  }
  
  func testStartAutoScroll_withParameters_backwards_noCycle_toPage1() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.1, forward: false, cycle: false, animated: false)
    
    // Scroll to page 1
    // -------------
    let expectation = expectationWithDescription("scroll")
    iiQ.runAfterDelay(0.35) { expectation.fulfill() }
    waitForExpectationsWithTimeout(1) { _ in }
    XCTAssertEqual(0, auk.currentPageIndex)
  }
}
