import UIKit
import XCTest

class AukPageIndicatorTests: XCTestCase {
  
  var settings: AukSettings!
  var pageIndicator: AukPageIndicator!
  
  override func setUp() {
    super.setUp()
    
    settings = AukSettings()
    pageIndicator = AukPageIndicator()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Setup
  
  func testSetup_createPageControl() {
    settings.pageControl.cornerRadius = 14
    
    pageIndicator.setup(settings)
    
    let pageControl = pageIndicator.subviews[0] as! UIPageControl
    XCTAssertEqual(14, pageControl.layer.cornerRadius)
  }
  
  func testSetup_setupMargins() {
    pageIndicator.setup(settings)
    
    let pageControl = pageIndicator.subviews[0] as? UIPageControl
    XCTAssert(pageControl != nil)
  }
}