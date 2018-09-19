import UIKit
import XCTest
@testable import Auk

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
  
  func testSetup_stylePageContainer() {
    settings.pageControl.cornerRadius = 14
    settings.pageControl.backgroundColor = UIColor.purple
    
    container.setup(settings, scrollView: scrollView)
    
    XCTAssertEqual(14, container.layer.cornerRadius)
    XCTAssertEqual(UIColor.purple, container.backgroundColor!)
    XCTAssert(container.isHidden)
  }
  
  func testSetup_layoutContainerView() {
    // Layout scroll view
    // ---------------

    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    superview.addSubview(scrollView)
    superview.addSubview(container)
    
    iiAutolayoutConstraints.height(scrollView, value: 100)
    iiAutolayoutConstraints.width(scrollView, value: 100)
    
    iiAutolayoutConstraints.alignSameAttributes(scrollView, toItem: superview,
                                                constraintContainer: superview, attribute: NSLayoutConstraint.Attribute.left, margin: 0)
    
    iiAutolayoutConstraints.alignSameAttributes(scrollView, toItem: superview,
                                                constraintContainer: superview, attribute: NSLayoutConstraint.Attribute.top, margin: 10)
    
    settings.pageControl.marginToScrollViewBottom = 13
    
    // Setup page view container
    container.setup(settings, scrollView: scrollView)
    
    superview.layoutIfNeeded()
    
    // Check container layout
    // ---------------
    
    XCTAssertEqual(97, container.frame.origin.y + container.bounds.height)
    XCTAssertEqual(50, container.frame.midX)
  }
  
  func testSetup_stylePageControl() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    settings.pageControl.pageIndicatorTintColor = UIColor.blue
    settings.pageControl.currentPageIndicatorTintColor = UIColor.red
    
    // Create the views
    container.setup(settings, scrollView: scrollView)
    
    let pageControl = container.subviews[0] as! UIPageControl
    
    // Verify page control layout
    // ---------------
    
    XCTAssertEqual(UIColor.blue, pageControl.pageIndicatorTintColor!)
    XCTAssertEqual(UIColor.red, pageControl.currentPageIndicatorTintColor!)
  }
  
  func testSetup_layoutPageControl() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    superview.addSubview(scrollView)
    superview.addSubview(container)

    iiAutolayoutConstraints.height(scrollView, value: 100)
    iiAutolayoutConstraints.width(scrollView, value: 100)
    
    iiAutolayoutConstraints.alignSameAttributes(scrollView, toItem: superview,
                                                constraintContainer: superview, attribute: NSLayoutConstraint.Attribute.left, margin: 0)
    
    iiAutolayoutConstraints.alignSameAttributes(scrollView, toItem: superview,
                                                constraintContainer: superview, attribute: NSLayoutConstraint.Attribute.top, margin: 10)
    
    settings.pageControl.innerPadding = CGSize(width: 13, height: 18)
    
    
    // Create the views
    container.setup(settings, scrollView: scrollView)
    
    superview.layoutIfNeeded()
    container.layoutIfNeeded()

    let pageControl = container.subviews[0] as! UIPageControl
    
    // Verify page control layout
    // ---------------

    XCTAssertEqual(13 * 2, container.bounds.width - pageControl.bounds.width)
    XCTAssertEqual(18 * 2, container.bounds.height - pageControl.bounds.height)
  }
  
  // MARK: - Update number of pages
  
  func testUpdateNumberOfPages() {
    container.setup(settings, scrollView: scrollView)
    container.updateNumberOfPages(3)
    
    let pageControl = container.subviews[0] as! UIPageControl
    XCTAssertEqual(3, pageControl.numberOfPages)
  }
  
  // MARK: - Update current page
  
  func testUpdateCurrentPage() {
    container.setup(settings, scrollView: scrollView)
    container.updateNumberOfPages(10)
    container.updateCurrentPage(7)

    let pageControl = container.subviews[0] as! UIPageControl
    XCTAssertEqual(7, pageControl.currentPage)
  }
  
  // MARK: - Show / hide
  
  func testHiddenForOnePage() {
    container.setup(settings, scrollView: scrollView)
    container.updateNumberOfPages(1)
    XCTAssert(container.isHidden)
  }
  
  func testVisibleForTwoPages() {
    container.setup(settings, scrollView: scrollView)
    container.updateNumberOfPages(2)
    XCTAssertFalse(container.isHidden)
  }
  
  func testHideWhenNoPages() {
    container.setup(settings, scrollView: scrollView)
    container.updateNumberOfPages(2)
    container.updateNumberOfPages(0)

    XCTAssert(container.isHidden)
  }
  
  // MARK: Tap container
  
  func testTapContainer() {
    var receivePageIndex: Int?
    
    container.didTapPageControlCallback = { pageIndex in
      receivePageIndex = pageIndex
    }
    
    container.setup(settings, scrollView: scrollView)
    container.pageControl?.numberOfPages = 1000
    container.pageControl?.currentPage = 312
    container.didTapPageControl(container.pageControl!)
    
    XCTAssertEqual(312, receivePageIndex!)
  }
}
