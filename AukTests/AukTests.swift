import UIKit
import XCTest
import moa

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
  
  override func tearDown() {
    super.tearDown()
    
    MoaSimulator.clear()
  }
  
  // MARK: - Setup
  
  func testSetup_style() {
    auk = Auk(scrollView: scrollView)
    auk.setup()
    
    XCTAssertFalse(scrollView.showsHorizontalScrollIndicator)
    XCTAssert(scrollView.pagingEnabled)
  }
  
  func testSetup_createPageIndicator() {
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
      constraintContainer: superview, attribute: NSLayoutAttribute.Top, margin: 0)

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

  // MARK: - Show local image
  
  func testSetupIsCalled() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    XCTAssertFalse(scrollView.showsHorizontalScrollIndicator)
  }
  
  func testShowLocalImage() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(96, firstAukImage(scrollView, index: 0)!.size.width)
  }
  
  func testShowLocalImage_layoutSubviews() {
    let image1 = uiImageFromFile("96px.png")
    auk.show(image: image1)
    
    let image2 = uiImageFromFile("67px.png")
    auk.show(image: image2)
    
    scrollView.layoutIfNeeded()
    
    // Check content size
    // -------------
    
    XCTAssertEqual(CGSize(width: 240, height: 90), scrollView.contentSize)
    
    // View 1
    // -------------
    
    let aukView1 = aukPages(scrollView)[0]
    XCTAssertEqual(CGPoint(x: 0, y: 0), aukView1.frame.origin)
    XCTAssertEqual(CGSize(width: 120, height: 90), aukView1.frame.size)
    
    // View 2
    // -------------
    
    let aukView2 = aukPages(scrollView)[1]
    XCTAssertEqual(CGPoint(x: 120, y: 0), aukView2.frame.origin)
    XCTAssertEqual(CGSize(width: 120, height: 90), aukView2.frame.size)
  }
  
  // MARK: - Show remote image
  
  func testShowRemoteImage_setupIsCalled() {
    MoaSimulator.simulate("site.com")
    
    auk.show(url: "http://site.com/image.png")
    
    XCTAssertFalse(scrollView.showsHorizontalScrollIndicator)
  }
  
  func testShowRemoteImage() {
    let simulator = MoaSimulator.simulate("auk.png")

    auk.show(url: "http://site.com/auk.png")
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.png", simulator.downloaders.first!.url)
    
    scrollView.layoutIfNeeded()
    
    let image = uiImageFromFile("67px.png")
    simulator.respondWithImage(image)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(67, firstAukImage(scrollView, index: 0)!.size.width)
  }
  
  func testShowRemoteImage_showSecondImageWhenScrolled() {
    let simulator = MoaSimulator.simulate("site.com")
        
    // Add two remote images
    auk.show(url: "http://site.com/auk.png")
    auk.show(url: "http://site.com/moa.png")

    // The first image is requested at first
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.png", simulator.downloaders.first!.url)
    XCTAssertFalse(simulator.downloaders.first!.cancelled)

    // Scroll to make the second image visible
    scrollView.contentOffset.x = 10
    scrollView.delegate?.scrollViewDidScroll?(scrollView)
    
    // The second image is requested
    XCTAssertEqual(2, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/moa.png", simulator.downloaders.last!.url)
    XCTAssertFalse(simulator.downloaders.last!.cancelled)
    
    // Scroll to hide the first image
    scrollView.contentOffset.x = 120
    scrollView.delegate?.scrollViewDidScroll?(scrollView)
    
    // Download of first image is NOT cancelled yet because it is close (though not visible)
    XCTAssertFalse(simulator.downloaders.first!.cancelled)
    
    // Scroll more to cancel first image download
    scrollView.contentOffset.x = 180
    scrollView.delegate?.scrollViewDidScroll?(scrollView)
    
    // Download of first image is cancelled
    XCTAssert(simulator.downloaders.first!.cancelled)
  }
  
  func testShowRemoteImage_layoutSubviews() {
    MoaSimulator.simulate("site.com")

    auk.show(url: "http://site.com/image1.png")
    auk.show(url: "http://site.com/image2.png")
    
    scrollView.layoutIfNeeded()
    
    // Check content size
    // -------------
    
    XCTAssertEqual(CGSize(width: 240, height: 90), scrollView.contentSize)
    
    // View 1
    // -------------
    
    let aukView1 = aukPages(scrollView)[0]
    XCTAssertEqual(CGPoint(x: 0, y: 0), aukView1.frame.origin)
    XCTAssertEqual(CGSize(width: 120, height: 90), aukView1.frame.size)
    
    // View 2
    // -------------
    
    let aukView2 = aukPages(scrollView)[1]
    XCTAssertEqual(CGPoint(x: 120, y: 0), aukView2.frame.origin)
    XCTAssertEqual(CGSize(width: 120, height: 90), aukView2.frame.size)
  }
  
  // MARK: get number of pages
  
  func testNumberOfPage() {
    // Show 2 images
    // -------------
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    
    XCTAssertEqual(2, auk.numberOfPages)
  }
  
  // MARK: get current page index
  
  func testCurrentPageIndex() {
    // Show 2 images
    // -------------
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    XCTAssertEqual(0, auk.currentPageIndex)
    
    // Scroll to show more than the half of the second page
    scrollView.contentOffset.x = 70
    
    XCTAssertEqual(1, auk.currentPageIndex)
    
    // Scroll to the second image
    scrollView.contentOffset.x = 120
    
    XCTAssertEqual(1, auk.currentPageIndex)
    
    // Scroll to show the third page ALMOST entirely
    scrollView.contentOffset.x = 230
    
    XCTAssertEqual(2, auk.currentPageIndex)
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
}
