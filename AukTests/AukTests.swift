import XCTest
import UIKit
@testable import Auk

class AukTests: XCTestCase {
  
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
  
  // MARK: - Setup
  
  func testSetup_style() {
    auk = Auk(scrollView: scrollView)
    auk.setup()
    
    XCTAssertFalse(scrollView.showsHorizontalScrollIndicator)
    XCTAssert(scrollView.isPagingEnabled)
  }
  
  // MARK: Page indicator
  
  func testSetup_createPageIndicator() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    superview.addSubview(scrollView)
    
    iiAutolayoutConstraints.height(scrollView, value: 100)
    iiAutolayoutConstraints.width(scrollView, value: 100)
    
    iiAutolayoutConstraints.alignSameAttributes(scrollView, toItem: superview,
      constraintContainer: superview, attribute: NSLayoutAttribute.left, margin: 0)
    
    iiAutolayoutConstraints.alignSameAttributes(scrollView, toItem: superview,
      constraintContainer: superview, attribute: NSLayoutAttribute.top, margin: 0)

    auk = Auk(scrollView: scrollView)
    
    // Setup the auk which will create the page view
    // ---------------

    auk.settings.pageControl.marginToScrollViewBottom = 11
    auk.setup()
    
    superview.layoutIfNeeded()
    
    // Check the page indicator layout
    // -----------
    
    XCTAssertEqual(89, auk.pageIndicatorContainer!.frame.maxY)
  }
  
  func testSetup_doNotCreatePageIndicator() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    superview.addSubview(scrollView)
    
    iiAutolayoutConstraints.height(scrollView, value: 100)
    iiAutolayoutConstraints.width(scrollView, value: 100)
    
    iiAutolayoutConstraints.alignSameAttributes(scrollView, toItem: superview,
      constraintContainer: superview, attribute: NSLayoutAttribute.left, margin: 0)
    
    iiAutolayoutConstraints.alignSameAttributes(scrollView, toItem: superview,
      constraintContainer: superview, attribute: NSLayoutAttribute.top, margin: 0)
    
    auk = Auk(scrollView: scrollView)
    
    // Setup the auk which will create the page view
    // ---------------
    
    auk.settings.pageControl.visible = false
    auk.setup()
    
    superview.layoutIfNeeded()
    
    // Check the page indicator layout
    // -----------
    
    XCTAssert(auk.pageIndicatorContainer == nil)
  }
  
  func testSetup_createSinglePageIndicator() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    auk = Auk(scrollView: scrollView)
    
    // Call setup multiple times
    // ---------------
    
    auk.setup()
    auk.setup()
    auk.setup()

    // Verify that only one page indicator container has been created
    // ---------------
    
    let indicators = superview.subviews.filter { $0 as? AukPageIndicatorContainer != nil }
    XCTAssertEqual(1, indicators.count)
  }
  
  // MARK: - Update page indicator
  
  func testPageIndicator_updateCurrentPage_updateNumberOfPages() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    // Show 3 images
    // -------------
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    // Verify page indicator is showing three pages
    // -------------
    
    XCTAssertEqual(3, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
  }
  
  func testPageIndicator_updateCurrentPage() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    // Show 3 images
    // -------------
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    // Scroll to the first page
    // ------------
    
    scrollView.contentOffset.x = 0
    scrollView.delegate?.scrollViewDidScroll?(scrollView)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Scroll to the second page
    // -------------

    scrollView.contentOffset.x = 120
    scrollView.delegate?.scrollViewDidScroll?(scrollView)    
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
  }

  // MARK: - Show / hide page indicator
  
  func testPageIndicator_showForTwoPages() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    
    XCTAssertFalse(auk.pageIndicatorContainer!.isHidden)
  }
  
  func testPageIndicator_hideWhenPagesRemoved() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.removeAll()
    
    XCTAssert(auk.pageIndicatorContainer!.isHidden)
  }
  
  func testPageIndicator_scrollWhenPageIndicatorIsTapped() {
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
        
    auk.pageIndicatorContainer!.pageControl!.currentPage = 1
    auk.pageIndicatorContainer?.didTapPageControl(auk.pageIndicatorContainer!.pageControl!)
    
    XCTAssertEqual(120, scrollView.contentOffset.x)
  }
  
  
  // MARK: - updatePageIndicator

  
  func testUpdateTestIndicator() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let aukView1 = AukPage()
    let aukView2 = AukPage()
    
    scrollView.addSubview(aukView1)
    scrollView.addSubview(aukView2)
    
    // Create page indicator
    // ---------------
    
    let pageIndicator = AukPageIndicatorContainer()
    auk.pageIndicatorContainer = pageIndicator
    superview.addSubview(pageIndicator)
    pageIndicator.setup(auk.settings, scrollView: scrollView)
    
    superview.layoutIfNeeded()
    
    // Verify page indicator is showing the pages
    // -------------
    
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(-1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    auk.updatePageIndicator()
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    scrollView.contentOffset = CGPoint(x: 200, y: 0)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    auk.updatePageIndicator()
  }
}
