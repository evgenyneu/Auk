import XCTest
@testable import Auk

class AukInterfaceRemovePageTests: XCTestCase {
  
  var scrollView: UIScrollView!
  var auk: Auk!
  var fakeAnimator: iiFakeAnimator!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 120, height: 90)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
    
    auk = Auk(scrollView: scrollView)
    
    // Use fake animator
    fakeAnimator = iiFakeAnimator()
    iiAnimator.currentAnimator = fakeAnimator

  }

  override func tearDown() {
    super.tearDown()
    
    iiAnimator.currentAnimator = nil // Remove the fake animator
  }

  func testRemoveFirstImage() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    // Current page index is 0, and 4 pages
    
    // Remove first page
    auk.removePage(atIndex: 0)
    
    // Expect to have 3 pages left
    XCTAssertEqual(3, aukPages(scrollView).count)
    XCTAssertEqual(3, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (3 pages left, current page index 0)
    XCTAssertEqual(3, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Scroll to next page, so current page index should be 1
    auk.scrollToNextPage()
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: 0)

    // Expect to have 2 pages left
    XCTAssertEqual(2, aukPages(scrollView).count)
    XCTAssertEqual(2, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (2 pages left, current page index 1)
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: 0)

    // Expect to have 1 pages left
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(1, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (1 pages left, current page index 0)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
  }
  
  func testRemoveLastImage() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    // Current page index is 0, and 4 pages
    
    // Remove first page
    auk.removePage(atIndex: auk.numberOfPages - 1)
    
    // Expect to have 3 pages left
    XCTAssertEqual(3, aukPages(scrollView).count)
    XCTAssertEqual(3, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (3 pages left, current page index 0)
    XCTAssertEqual(3, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Scroll to next page, so current page index should be 1
    auk.scrollToNextPage()
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: auk.numberOfPages - 1)
    
    // Expect to have 2 pages left
    XCTAssertEqual(2, aukPages(scrollView).count)
    XCTAssertEqual(2, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (2 pages left, current page index 1)
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: auk.numberOfPages - 1)
    
    // Expect to have 1 pages left
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(1, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (1 pages left, current page index 0)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
  }
  
  func testRemovePage_withoutAnimation() {
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = createImage96px()
    auk.show(image: image)
    
    // Remove first page
    auk.removePage(atIndex: 0)
    
    // Expect NOT to use animation by default
    XCTAssertEqual(0, fakeAnimator.testParameters.count)
  }
  
  func testRemovePage_withoutAnimation_callCompletion() {
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = createImage96px()
    auk.show(image: image)
    
    var didCallCompletion = false
    
    auk.removePage(atIndex: 0, completion: {
      didCallCompletion = true
    })
    
    // Expect NOT to use animation by default
    XCTAssertEqual(0, fakeAnimator.testParameters.count)
    
    XCTAssertTrue(didCallCompletion)
  }
  
  func testRemovePage_withAnimation() {
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    
    auk.removePage(atIndex: 0, animated: true)
    
    // Expect fade-out animation
    XCTAssertEqual(1, fakeAnimator.testParameters.count)
    XCTAssertEqual("Fade out", fakeAnimator.testParameters[0].name)
    XCTAssertEqual(0.2, fakeAnimator.testParameters[0].duration) // Default fade out animation
    
    let page = aukPage(scrollView, pageIndex: 0)
    
    // Page is still visible
    XCTAssertEqual(1, page?.alpha)
    
    // Call fade out animation function
    fakeAnimator.testParameters[0].animation()
    XCTAssertEqual(0, page?.alpha) // Hidden
    
    // Call fade out animation completion
    fakeAnimator.testParameters[0].completion!(true)
    
    // Expect layout animation
    XCTAssertEqual(2, fakeAnimator.testParameters.count)
    XCTAssertEqual("layoutIfNeeded", fakeAnimator.testParameters[1].name)
    XCTAssertEqual(0.3, fakeAnimator.testParameters[1].duration) // Default layout animation

    XCTAssertEqual(240, scrollView.contentSize.width)
    
    // Call layout animation function
    fakeAnimator.testParameters[1].animation()
    XCTAssertEqual(120, scrollView.contentSize.width)
    
    // Number of pages are not yet updates
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)

    // Call layout animation completion
    fakeAnimator.testParameters[1].completion!(true)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
  }
  
  func testRemovePage_withAnimation_callCompletion() {
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    
    var didCallCompletion = false
    auk.removePage(atIndex: 0, animated: true, completion: {
      didCallCompletion = true
    })
    
    // Not yet called
    XCTAssertFalse(didCallCompletion)
    
    XCTAssertEqual("Fade out", fakeAnimator.testParameters[0].name)
    // Call fade out animation completion
    fakeAnimator.testParameters[0].completion!(true)
    
    // Not yet called
    XCTAssertFalse(didCallCompletion)
    
    XCTAssertEqual("layoutIfNeeded", fakeAnimator.testParameters[1].name)
    // Call layout animation completion
    fakeAnimator.testParameters[1].completion!(true)
    
    // Completion called
    XCTAssert(didCallCompletion)
  }
  
  func testRemoveCurrentImage() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    // Current page index is 0, and 4 pages
    
    // Remove first page
    auk.removePage(atIndex: auk.currentPageIndex!)
    
    // Expect to have 3 pages left
    XCTAssertEqual(3, aukPages(scrollView).count)
    XCTAssertEqual(3, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (3 pages left, current page index 0)
    XCTAssertEqual(3, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Scroll to next page, so current page index should be 1
    auk.scrollToNextPage()
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: auk.currentPageIndex!)
    
    // Expect to have 2 pages left
    XCTAssertEqual(2, aukPages(scrollView).count)
    XCTAssertEqual(2, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (2 pages left, current page index 1)
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: auk.currentPageIndex!)
    
    // Expect to have 1 pages left
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(1, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (1 pages left, current page index 0)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
  }
}
