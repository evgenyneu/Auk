import XCTest
import moa
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
  
  // MARK: - removePage
  // ------------------------------

  func testRemoveFirstImage() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image96px = createImage96px()
    auk.show(image: image96px)
    auk.show(image: createImage67px())
    auk.show(image: createImage35px())
    auk.show(image: image96px)
    
    // Current page index is 0, and 4 pages
    
    // Remove first page
    auk.removePage(atIndex: 0)
    
    // Expect correct image sizes
    XCTAssertEqual(67, firstAukImageWidth(scrollView, pageIndex: 0))
    XCTAssertEqual(35, firstAukImageWidth(scrollView, pageIndex: 1))
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 2))
    
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
    
    // Expect correct image sizes
    XCTAssertEqual(35, firstAukImageWidth(scrollView, pageIndex: 0))
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 1))

    // Expect to have 2 pages left
    XCTAssertEqual(2, aukPages(scrollView).count)
    XCTAssertEqual(2, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (2 pages left, current page index 1)
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: 0)
    
    // Expect correct image size
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 0))

    // Expect to have 1 pages left
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(1, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (1 pages left, current page index 0)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: 0)
    
    // Expect to have no pages left
    XCTAssertEqual(0, aukPages(scrollView).count)
  }
  
  func testRemoveLastImage() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: createImage67px())
    auk.show(image: createImage35px())
    auk.show(image: image)
    
    // Current page index is 0, and 4 pages
    
    // Remove last page
    auk.removePage(atIndex: auk.numberOfPages - 1)
    
    // Expect correct image sizes
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 0))
    XCTAssertEqual(67, firstAukImageWidth(scrollView, pageIndex: 1))
    XCTAssertEqual(35, firstAukImageWidth(scrollView, pageIndex: 2))

    // Expect to have 3 pages left
    XCTAssertEqual(3, aukPages(scrollView).count)
    XCTAssertEqual(3, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (3 pages left, current page index 0)
    XCTAssertEqual(3, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Scroll to next page, so current page index should be 1
    auk.scrollToNextPage()
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove last page
    auk.removePage(atIndex: auk.numberOfPages - 1)
    
    // Expect correct image sizes
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 0))
    XCTAssertEqual(67, firstAukImageWidth(scrollView, pageIndex: 1))
    
    // Expect to have 2 pages left
    XCTAssertEqual(2, aukPages(scrollView).count)
    XCTAssertEqual(2, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (2 pages left, current page index 1)
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove last page
    auk.removePage(atIndex: auk.numberOfPages - 1)
    
    // Expect correct image size
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 0))
    
    // Expect to have 1 pages left
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(1, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (1 pages left, current page index 0)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
  }
  
  
  func testRemoveImage_scrollViewWithNoImages() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    // Remove
    auk.removePage(atIndex: 0)
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
  
  func testRemovePage_withAnimation_notifyPagesAboutTheirVisibitliy() {
    let simulate = MoaSimulator.simulate("site.com")
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    auk.show(url: "http://site.com/one.jpg")
    auk.show(url: "http://site.com/two.jpg")

    // Dowload the first page initially
    XCTAssertEqual(1, simulate.downloaders.count)
    XCTAssertEqual("http://site.com/one.jpg", simulate.downloaders[0].url)
    
    auk.removePage(atIndex: 0, animated: true)
    
    // Still has single download
    XCTAssertEqual(1, simulate.downloaders.count)
    
    // Call fade out animation completion
    fakeAnimator.testParameters[0].completion!(true)
    
    // Still has single download
    XCTAssertEqual(1, simulate.downloaders.count)
    
    // Call layout animation completion
    fakeAnimator.testParameters[1].completion!(true)
    
    // Dowload the second page
    XCTAssertEqual(2, simulate.downloaders.count)
    XCTAssertEqual("http://site.com/two.jpg", simulate.downloaders[1].url)
  }
  
  func testRemovePage_withoutAnimation_notifyPagesAboutTheirVisibitliy() {
    let simulate = MoaSimulator.simulate("site.com")
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    auk.show(url: "http://site.com/one.jpg")
    auk.show(url: "http://site.com/two.jpg")
    
    // Dowload the first page initially
    XCTAssertEqual(1, simulate.downloaders.count)
    XCTAssertEqual("http://site.com/one.jpg", simulate.downloaders[0].url)
    
    auk.removePage(atIndex: 0)
    
    // Dowload the second page
    XCTAssertEqual(2, simulate.downloaders.count)
    XCTAssertEqual("http://site.com/two.jpg", simulate.downloaders[1].url)
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
  
  func testRemovePage_withAnimation_useCustomAnimationDurations() {
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    auk.settings.removePageFadeOutAnimationDurationSeconds = 0.111
    auk.settings.removePageLayoutAnimationDurationSeconds = 0.222

    auk.removePage(atIndex: 0, animated: true)
    
    // Expect fade-out animation
    XCTAssertEqual("Fade out", fakeAnimator.testParameters[0].name)
    XCTAssertEqual(0.111, fakeAnimator.testParameters[0].duration)
    
    // Call fade out animation completion
    fakeAnimator.testParameters[0].completion!(true)
    
    // Expect layout animation
    XCTAssertEqual("layoutIfNeeded", fakeAnimator.testParameters[1].name)
    XCTAssertEqual(0.222, fakeAnimator.testParameters[1].duration)
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
  
  func testRemovePage_cancelImageDownload() {
    let simulate = MoaSimulator.simulate("site.com")
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    auk.show(url: "http://site.com/one.jpg")
    auk.show(url: "http://site.com/two.jpg")
    
    // Dowload the first page initially
    XCTAssertEqual(1, simulate.downloaders.count)
    XCTAssertEqual("http://site.com/one.jpg", simulate.downloaders[0].url)
    XCTAssertFalse(simulate.downloaders[0].cancelled)
    
    auk.removePage(atIndex: 0)
    
    XCTAssertEqual(2, simulate.downloaders.count)
    
    // Cancel the first image download
    XCTAssertTrue(simulate.downloaders[0].cancelled)
    
    // The second image download is NOT cancelled
    XCTAssertFalse(simulate.downloaders[1].cancelled)
  }
  
  
  
  
  
  
  
  
  // MARK: - removeCurrentPage
  // ------------------------------
  
  func testRemoveCurrentImage() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image96px = createImage96px()
    auk.show(image: image96px)
    auk.show(image: createImage67px())
    auk.show(image: createImage35px())
    auk.show(image: image96px)
    
    // Current page index is 0, and 4 pages
    
    // Remove current image
    auk.removeCurrentPage()
    
    // Expect correct image sizes
    XCTAssertEqual(67, firstAukImageWidth(scrollView, pageIndex: 0))
    XCTAssertEqual(35, firstAukImageWidth(scrollView, pageIndex: 1))
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 2))
    
    // Expect to have 3 pages left
    XCTAssertEqual(3, aukPages(scrollView).count)
    XCTAssertEqual(3, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (3 pages left, current page index 0)
    XCTAssertEqual(3, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Scroll to next page, so current page index should be 1
    auk.scrollToNextPage()
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove current image
    auk.removeCurrentPage()
    
    // Expect correct image sizes
    XCTAssertEqual(67, firstAukImageWidth(scrollView, pageIndex: 0))
    XCTAssertEqual(96, firstAukImageWidth(scrollView, pageIndex: 1))
    
    // Expect to have 2 pages left
    XCTAssertEqual(2, aukPages(scrollView).count)
    XCTAssertEqual(2, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (2 pages left, current page index 1)
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove current image
    auk.removeCurrentPage()
    
    // Expect correct image sizes
    XCTAssertEqual(67, firstAukImageWidth(scrollView, pageIndex: 0))
    
    // Expect to have 1 pages left
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(1, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (1 pages left, current page index 0)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
  }
  
  func testRemoveCurrentImage_animated_callCompletion() {
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    
    var didCallCompletion = false
    auk.removeCurrentPage(animated: true, completion: {
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
}
