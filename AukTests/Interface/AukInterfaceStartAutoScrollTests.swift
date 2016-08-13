import XCTest
import UIKit
@testable import Auk

class AukInterfaceStartAutoScrollTests: XCTestCase {
  
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
  
  override func tearDown() {
    super.tearDown()
    auk.stopAutoScroll()
  }
  
  // MARK: - Start auto scroll
  
  func testStartAutoScroll_toPage1() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)

    auk.startAutoScroll(delaySeconds: 0.2)

    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.3) { expectation.fulfill() }
    waitForExpectations(timeout: 1) { _ in }
    XCTAssertEqual(1, auk.currentPageIndex)
  }
  
  func testStartAutoScrollMultipleTimes_onlyScrollsOnce() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2)
    auk.startAutoScroll(delaySeconds: 0.2)
    auk.startAutoScroll(delaySeconds: 0.2)
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.3) { expectation.fulfill() }
    waitForExpectations(timeout: 1) { _ in }
    XCTAssertEqual(1, auk.currentPageIndex)
  }
  
  func testStartAutoScroll_toPage2() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2)
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.5) { expectation.fulfill() }
    waitForExpectations(timeout: 1) { _ in }
    XCTAssertEqual(2, auk.currentPageIndex)
  }
  
  func testStartAutoScroll_cycleToPag0() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2)
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.7) { expectation.fulfill() }
    waitForExpectations(timeout: 2) { _ in }
    XCTAssertEqual(0, auk.currentPageIndex)
  }
  
  // MARK: - With parameters, forward
  
  func testStartAutoScroll_withParameters_forward_toPage1() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2, forward: true, cycle: true, animated: false)
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.3) { expectation.fulfill() }
    waitForExpectations(timeout: 1) { _ in }
    XCTAssertEqual(1, auk.currentPageIndex)
  }
  
  func testStartAutoScroll_withParameters_backwards_toPage2() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2, forward: false, cycle: true, animated: false)
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.25) { expectation.fulfill() }
    waitForExpectations(timeout: 1) { _ in }
    XCTAssertEqual(2, auk.currentPageIndex)
  }
  
  // MARK: - With parameters, forward, cycle
  
  func testStartAutoScroll_withParameters_forward_cycle_toPage1() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2, forward: true, cycle: true, animated: false)
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.7) { expectation.fulfill() }
    waitForExpectations(timeout: 2) { _ in }
    XCTAssertEqual(0, auk.currentPageIndex)
  }
  
  func testStartAutoScroll_withParameters_forward_noCycle_toPage1() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2, forward: true, cycle: false, animated: false)
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.5) { expectation.fulfill() }
    waitForExpectations(timeout: 1) { _ in }
    XCTAssertEqual(2, auk.currentPageIndex)
  }
  
  // MARK: - With parameters, backwards, cycle
  
  func testStartAutoScroll_withParameters_backwards_cycle_toPage1() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2, forward: false, cycle: true, animated: false)
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.3) { expectation.fulfill() }
    waitForExpectations(timeout: 1) { _ in }
    XCTAssertEqual(2, auk.currentPageIndex)
  }
  
  func testStartAutoScroll_withParameters_backwards_noCycle_toPage1() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2, forward: false, cycle: false, animated: false)
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.5) { expectation.fulfill() }
    waitForExpectations(timeout: 1) { _ in }
    XCTAssertEqual(0, auk.currentPageIndex)
  }
  
  // MARK: - Stop autoscroll
  
  func testStopAutoScroll() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2)
    auk.stopAutoScroll()
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.3) { expectation.fulfill() }
    waitForExpectations(timeout: 1) { _ in }
    XCTAssertEqual(0, auk.currentPageIndex)
  }
  
  // MARK: - Cancel autoscroll when it is scrolled by user.
  
  func testStopAutoScrollWhenScrolledByUser() {
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.startAutoScroll(delaySeconds: 0.2)
    
    auk.scrollViewDelegate.scrollViewWillBeginDragging(scrollView)
    
    let expectation = self.expectation(description: "scroll")
    iiQ.runAfterDelay(0.3) { expectation.fulfill() }
    waitForExpectations(timeout: 1) { _ in }
    XCTAssertEqual(0, auk.currentPageIndex)
  }
}
