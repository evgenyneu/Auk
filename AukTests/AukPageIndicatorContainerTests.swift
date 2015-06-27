import UIKit
import XCTest

class AukPageIndicatorTests: XCTestCase {
  
  var settings: AukSettings!
  var container: AukPageIndicatorContainer!
  var scrollView: UIScrollView!
  
  override func setUp() {
    super.setUp()
    
    settings = AukSettings()
    container = AukPageIndicatorContainer()
    scrollView = UIScrollView()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Setup
  
  func testSetup_createPageControl() {
    settings.pageControl.cornerRadius = 14
    settings.pageControl.backgroundColor = UIColor.purpleColor()
    
    container.setup(settings, scrollView: scrollView)
    
    XCTAssertEqual(14, container.layer.cornerRadius)
    XCTAssertEqual(UIColor.purpleColor(), container.backgroundColor!)
  }
  
  func testSetup_layoutContainerView() {
    // Layout scroll view
    // ---------------

    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
    superview.addSubview(scrollView)
    iiAutolayoutConstraints.height(scrollView, value: 100)
    iiAutolayoutConstraints.width(scrollView, value: 100)
    
    iiAutolayoutConstraints.alignSameAttributes(scrollView, toItem: superview,
      constraintContainer: superview, attribute: NSLayoutAttribute.Left, margin: 0)
    
    iiAutolayoutConstraints.alignSameAttributes(scrollView, toItem: superview,
      constraintContainer: superview, attribute: NSLayoutAttribute.Top, margin: 10)
    
    settings.pageControl.marginToScrollViewBottom = 13
    
    // Setup page view container
    container.setup(settings, scrollView: scrollView)
    
    superview.layoutIfNeeded()
    
    // Check container layout
    // ---------------
    
    XCTAssertEqual(97, container.frame.origin.y + container.bounds.height)
    XCTAssertEqual(50, container.frame.midX)
  }
}