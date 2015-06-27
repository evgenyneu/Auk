import UIKit
import XCTest
import moa

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
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView)
    
    XCTAssertEqual(1, simulate.downloaders.count)
    XCTAssertEqual("http://site.com/image_two.jpg", simulate.downloaders.first!.url)
    XCTAssertFalse(simulate.downloaders.first!.cancelled)
  }
  
  func testTellPagesAboutTheirVisibility_cancelTheDownloadOfFirstImage() {
    let simulate = MoaSimulator.simulate("site.com")
    
    // Show first page with remote image
    let aukPage1 = AukPage()
    scrollView.addSubview(aukPage1)
    aukPage1.show(url: "http://site.com/image_one.jpg", settings: settings)
    
    aukPage1.remoteImage?.downloadImage()
    
    // Show second page with remote image
    let aukPage2 = AukPage()
    scrollView.addSubview(aukPage2)
    aukPage2.show(url: "http://site.com/image_two.jpg", settings: settings)
    
    AukScrollViewContent.layout(scrollView)
    scrollView.layoutIfNeeded()
    
    // The second page is visible
    scrollView.contentOffset.x = 290
    
    // This will tell the first page that it is invisible, the page, in turn, cancels the download.
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView)
    
    XCTAssertEqual(2, simulate.downloaders.count)
    XCTAssert(simulate.downloaders.first!.cancelled)
  }
}