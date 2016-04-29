import XCTest
import moa
@testable import Auk

class AukPageVisibilityTests: XCTestCase {
  var scrollView: UIScrollView!
  var settings: AukSettings!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 290, height: 200)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
    
    settings = AukSettings()
  }
  
  override func tearDown() {
    super.tearDown()
    
    MoaSimulator.clear()
  }
  
  // MARK: - Is page visible
  
  func testIsVisible_firstPageVisible() {
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()

    XCTAssert(AukPageVisibility.isVisible(scrollView, page: aukPage1))
    XCTAssertFalse(AukPageVisibility.isVisible(scrollView, page: aukPage2))
  }

  func testIsVisible_bothPagesAreVisible() {
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()
    
    scrollView.contentOffset.x = 289

    XCTAssert(AukPageVisibility.isVisible(scrollView, page: aukPage1))
    XCTAssert(AukPageVisibility.isVisible(scrollView, page: aukPage2))
  }

  func testIsPageVisible_lastPageVisible() {
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()
    
    scrollView.contentOffset.x = 290
    
    XCTAssertFalse(AukPageVisibility.isVisible(scrollView, page: aukPage1))
    XCTAssert(AukPageVisibility.isVisible(scrollView, page: aukPage2))
  }
  
  // MARK: - tell pages about their visiblity
  
  func testTellPagesAboutTheirVisibility_theLastPageDownloadsTheImage() {
    let simulate = MoaSimulator.simulate("site.com")
    
    // Show first page with remote image
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    aukPage1.show(url: "http://site.com/image_one.jpg", settings: settings)
    
    // Show second page with remote image
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    aukPage2.show(url: "http://site.com/image_two.jpg", settings: settings)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()
    
    // The second page is visible
    scrollView.contentOffset.x = 290
    
    // This will tell the second page that it is visible and it will start the download
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 1)
    
    XCTAssertEqual(1, simulate.downloaders.count)
    XCTAssertEqual("http://site.com/image_two.jpg", simulate.downloaders.first!.url)
    XCTAssertFalse(simulate.downloaders.first!.cancelled)
  }
  
  func testTellPagesAboutTheirVisibility_startAndCancelImageDownloads() {
    let simulate = MoaSimulator.simulate("site.com")
    
    // Show first page with remote image
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    aukPage1.show(url: "http://site.com/image_one.jpg", settings: settings)
    
    aukPage1.remoteImage?.downloadImage(settings)
    
    // Show second page with remote image
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    aukPage2.show(url: "http://site.com/image_two.jpg", settings: settings)
    
    // Show third page with remote image
    let aukPage3 = AukPage()
    scrollView.addSubview(aukPage3)
    aukPage3.show(url: "http://site.com/image_three.jpg", settings: settings)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()
    
    // 1. Make the second page  visible
    // ---------------------
    
    scrollView.contentOffset.x = 290
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 1)
    
    XCTAssertEqual(2, simulate.downloaders.count)
    
    // Do not cancel the first image download just yet because it is still very close
    XCTAssertFalse(simulate.downloaders.first!.cancelled)
    
    // 2. Scroll a little bit firther to cancel first image download and start the third image download
    // ---------------------
    
    scrollView.contentOffset.x = 350
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 1)
    
    // Download of third image is started
    XCTAssertEqual(3, simulate.downloaders.count)
    XCTAssertEqual("http://site.com/image_three.jpg", simulate.downloaders.last!.url)
    XCTAssertFalse(simulate.downloaders.last!.cancelled)

    // Now the download of first image is cancelled because it is scrolled way out of view
    XCTAssert(simulate.downloaders.first!.cancelled)
    
    // 3. Now scroll back to the second page
    // ---------------------
    
    scrollView.contentOffset.x = 290
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 1)
    
    XCTAssertEqual(3, simulate.downloaders.count)
    
    // Third image download is not cancelled yet because it is still close (even though it is not visible)
    XCTAssertFalse(simulate.downloaders.last!.cancelled)
    
    // 4. Finally, scroll more towards the start to cancel download of third image
    // ---------------------
    
    scrollView.contentOffset.x = 220
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 1)
    
    XCTAssertEqual(4, simulate.downloaders.count)
    let thirdImageDownloader = simulate.downloaders[2]
    XCTAssertEqual("http://site.com/image_three.jpg", thirdImageDownloader.url)

    // Third image download is cancelled as it is far away now
    XCTAssert(thirdImageDownloader.cancelled)
  }
}