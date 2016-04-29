import XCTest
import moa
@testable import Auk

class AukPageVisibility_preloadImageTests: XCTestCase {
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
    settings.preloadRemoteImagesAround = 0
  }
  
  func testTellPagesAboutTheirVisibility_doNotPreloadImages() {
    settings.preloadRemoteImagesAround = 0
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
    
    // The first page is visible
    scrollView.contentOffset.x = 0
    
    // This will tell the second page that it is visible and it will start the download
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 0)
    
    // Load only first page image
    XCTAssertEqual(1, simulate.downloaders.count)
    
    // Download first image
    XCTAssertEqual("http://site.com/image_one.jpg", simulate.downloaders.first!.url)
    XCTAssertFalse(simulate.downloaders.first!.cancelled)
  }
  
  func testTellPagesAboutTheirVisibility_preloadOneImage() {
    settings.preloadRemoteImagesAround = 1
    let simulate = MoaSimulator.simulate("site.com")
    
    // Show first page with remote image
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    aukPage1.show(url: "http://site.com/image_one.jpg", settings: settings)
    
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
    
    // The first page is visible
    scrollView.contentOffset.x = 0
    
    // This will tell the second page that it is visible and it will start the download
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 0)
    
    // Load images for first two pages
    XCTAssertEqual(2, simulate.downloaders.count)
    
    // Download first image
    XCTAssertEqual("http://site.com/image_one.jpg", simulate.downloaders.first!.url)
    XCTAssertFalse(simulate.downloaders.first!.cancelled)
    
    // Download second image
    XCTAssertEqual("http://site.com/image_two.jpg", simulate.downloaders[1].url)
    XCTAssertFalse(simulate.downloaders[1].cancelled)
  }
  
  func testTellPagesAboutTheirVisibility_preloadOneImage_scrolledToSecond() {
    settings.preloadRemoteImagesAround = 1
    let simulate = MoaSimulator.simulate("site.com")
    
    // Show first page with remote image
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    aukPage1.show(url: "http://site.com/image_one.jpg", settings: settings)
    
    // Show second page with remote image
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    aukPage2.show(url: "http://site.com/image_two.jpg", settings: settings)
    
    // Show third page with remote image
    let aukPage3 = AukPage()
    scrollView.addSubview(aukPage3)
    aukPage3.show(url: "http://site.com/image_three.jpg", settings: settings)
    
    // Show third page with remote image
    let aukPage4 = AukPage()
    scrollView.addSubview(aukPage4)
    aukPage4.show(url: "http://site.com/image_four.jpg", settings: settings)
    
    // Show third page with remote image
    let aukPage5 = AukPage()
    scrollView.addSubview(aukPage5)
    aukPage5.show(url: "http://site.com/image_five.jpg", settings: settings)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()
    
    // The second page is visible
    scrollView.contentOffset.x = 290
    
    // This will tell the second page that it is visible and it will start the download
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 1)
    
    // Load images for three pages: the current, the previous and the next one.
    XCTAssertEqual(3, simulate.downloaders.count)
    
    // Download first image
    XCTAssertEqual("http://site.com/image_one.jpg", simulate.downloaders.first!.url)
    XCTAssertFalse(simulate.downloaders.first!.cancelled)
    
    // Download second image
    XCTAssertEqual("http://site.com/image_two.jpg", simulate.downloaders[1].url)
    XCTAssertFalse(simulate.downloaders[1].cancelled)
    
    // Download third image
    XCTAssertEqual("http://site.com/image_three.jpg", simulate.downloaders[2].url)
    XCTAssertFalse(simulate.downloaders[2].cancelled)
    
    // Now scroll to third page to cancel the first image download
    // -------------------
    
    scrollView.contentOffset.x = 580
    
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 2)
    
    XCTAssertEqual(4, simulate.downloaders.count)
    
    // Cancel first image
    XCTAssertEqual("http://site.com/image_one.jpg", simulate.downloaders.first!.url)
    XCTAssertTrue(simulate.downloaders.first!.cancelled)
    
    // Download second image
    XCTAssertEqual("http://site.com/image_two.jpg", simulate.downloaders[1].url)
    XCTAssertFalse(simulate.downloaders[1].cancelled)
    
    // Download third image
    XCTAssertEqual("http://site.com/image_three.jpg", simulate.downloaders[2].url)
    XCTAssertFalse(simulate.downloaders[2].cancelled)
    
    // Download fourth image
    XCTAssertEqual("http://site.com/image_four.jpg", simulate.downloaders[3].url)
    XCTAssertFalse(simulate.downloaders[3].cancelled)
    
    
    // Now scroll back to first image.
    // This cancels the fourth image download
    // and starts downloading the first again.
    // -------------------
    
    scrollView.contentOffset.x = 0
    
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 0)
    
    XCTAssertEqual(5, simulate.downloaders.count)
    
    // Cancel first image
    XCTAssertEqual("http://site.com/image_one.jpg", simulate.downloaders.first!.url)
    XCTAssertTrue(simulate.downloaders.first!.cancelled)
    
    // Download second image
    XCTAssertEqual("http://site.com/image_two.jpg", simulate.downloaders[1].url)
    XCTAssertFalse(simulate.downloaders[1].cancelled)
    
    // Cancel third image
    XCTAssertEqual("http://site.com/image_three.jpg", simulate.downloaders[2].url)
    XCTAssertTrue(simulate.downloaders[2].cancelled)
    
    // Cancel fourth image
    XCTAssertEqual("http://site.com/image_four.jpg", simulate.downloaders[3].url)
    XCTAssertTrue(simulate.downloaders[3].cancelled)
    
    // Download the first image again
    XCTAssertEqual("http://site.com/image_one.jpg", simulate.downloaders[4].url)
    XCTAssertFalse(simulate.downloaders[4].cancelled)
  }
  
  func testTellPagesAboutTheirVisibility_preloadTwoImages() {
    settings.preloadRemoteImagesAround = 2
    let simulate = MoaSimulator.simulate("site.com")
    
    // Show first page with remote image
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    aukPage1.show(url: "http://site.com/image_one.jpg", settings: settings)
    
    // Show second page with remote image
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    aukPage2.show(url: "http://site.com/image_two.jpg", settings: settings)
    
    // Show third page with remote image
    let aukPage3 = AukPage()
    scrollView.addSubview(aukPage3)
    aukPage3.show(url: "http://site.com/image_three.jpg", settings: settings)
    
    // Show third page with remote image
    let aukPage4 = AukPage()
    scrollView.addSubview(aukPage4)
    aukPage4.show(url: "http://site.com/image_four.jpg", settings: settings)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()
    
    // The first page is visible
    scrollView.contentOffset.x = 0
    
    // This will tell the second page that it is visible and it will start the download
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView,
                                                    settings: settings,
                                                    currentPageIndex: 0)
    
    // Load images for first three pages
    XCTAssertEqual(3, simulate.downloaders.count)
    
    // Download first image
    XCTAssertEqual("http://site.com/image_one.jpg", simulate.downloaders.first!.url)
    XCTAssertFalse(simulate.downloaders.first!.cancelled)
    
    // Download second image
    XCTAssertEqual("http://site.com/image_two.jpg", simulate.downloaders[1].url)
    XCTAssertFalse(simulate.downloaders[1].cancelled)
    
    // Download third image
    XCTAssertEqual("http://site.com/image_three.jpg", simulate.downloaders[2].url)
    XCTAssertFalse(simulate.downloaders[2].cancelled)
  }
}
  
