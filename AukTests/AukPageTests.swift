import XCTest
import moa
@testable import Auk

class AukPageTests: XCTestCase {
  
  var view: AukPage!
  var settings: AukSettings!
  
  override func setUp() {
    super.setUp()
    view = AukPage()
    settings = AukSettings()
  }
  
  override func tearDown() {
    super.tearDown()
    
    MoaSimulator.clear()
  }
  
  // MARK: - Show image
  
  func testShowImage() {
    let image = createImage67px()

    view.show(image: image, settings: settings)
    
    XCTAssertEqual(67, view.imageView!.image!.size.width)
  }
  
  func testShowImage_setup() {
    let image = createImage67px()
    
    view.show(image: image, settings: settings)
    
    XCTAssert(view.imageView != nil)
    
    // Do not create placeholder image view when showing local image
    XCTAssert(view.placeholderImageView == nil)
  }
  
  func testShowImage_useContentMode() {
    settings.contentMode = UIView.ContentMode.topRight
    let image = createImage67px()
    view.show(image: image, settings: settings)
    XCTAssertEqual(UIView.ContentMode.topRight.rawValue, view.imageView!.contentMode.rawValue)
  }
  
  func testShowImage_doNotcreatePlaceholderImage() {
    settings.placeholderImage = nil
    let image = createImage67px()
    
    view.show(image: image, settings: settings)
    
    XCTAssert(view.placeholderImageView == nil)
  }
  
  // MARK: - Show image by url
  
  func testShowUrl_useContentMode() {
    settings.contentMode = UIView.ContentMode.topRight
    view.show(url: "http://site.com/auk.jpg", settings: settings)
    XCTAssertEqual(UIView.ContentMode.topRight.rawValue, view.imageView!.contentMode.rawValue)
  }

  func testShowUrl() {
    view.show(url: "http://site.com/auk.jpg", settings: settings)
    
    XCTAssertEqual("http://site.com/auk.jpg", view.remoteImage!.url!)
  }
  
  func testShowUrl_setup() {
    view.show(url: "http://site.com/auk.jpg", settings: settings)
    
    XCTAssert(view.imageView != nil)
  }
  
  func testShowUrl_doNotcreatePlaceholderImage() {
    settings.placeholderImage = nil
    view.show(url: "http://site.com/auk.jpg", settings: settings)
    
    XCTAssert(view.placeholderImageView == nil)
  }
  
  func testShowUrl_createPlaceholderImage() {
    settings.placeholderImage = UIImage()
    view.show(url: "http://site.com/auk.jpg", settings: settings)
    
    XCTAssert(view.placeholderImageView != nil)
  }
  
  // MARK: - Visible now
  
  func testVisibleNow() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    let imageView = UIImageView()
    
    view.remoteImage = AukRemoteImage()
    view.remoteImage?.setup("http://site.com/auk.jpg", imageView: imageView,
      placeholderImageView: nil, settings: settings)
    
    view.visibleNow(settings)
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.first!.url)
    
    let image = createImage35px()
    simulator.respondWithImage(image)
    
    XCTAssertEqual(35, imageView.image!.size.width)
  }
  
  func testVisibleNow_whenCalledTwiceDownloadOnlyOnce() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    let imageView = UIImageView()
    
    view.remoteImage = AukRemoteImage()
    view.remoteImage?.setup("http://site.com/auk.jpg", imageView: imageView,
      placeholderImageView: nil, settings: settings)
    
    view.visibleNow(settings)
    view.visibleNow(settings)
    
    let image = createImage35px()
    simulator.respondWithImage(image)
    
    XCTAssertEqual(1, simulator.downloaders.count)
  }
  
  // MARK: - Out of sight now
  
  func testOutOfSightNow_cancelCurrentImageDownload() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    let imageView = UIImageView()
    view.remoteImage = AukRemoteImage()
    view.remoteImage?.setup("http://site.com/auk.jpg", imageView: imageView,
      placeholderImageView: nil, settings: settings)
    
    // Request image download
    imageView.moa.url = "http://site.com/auk.jpg"
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.first!.url)

    view.outOfSightNow()
    
    XCTAssert(simulator.downloaders.first!.cancelled)
    XCTAssert(imageView.moa.url == nil)
  }
  
  // MARK: - Remove image views
  
  func testRemoveImage() {
    let image = createImage67px()
    view.show(image: image, settings: settings)
    view.removeImageViews()
    
    XCTAssertNil(view.imageView)
  }
  
  func testRemovePlaceholderImage() {
    settings.placeholderImage = UIImage()
    view.show(url: "http://site.com/auk.jpg", settings: settings)
    view.removeImageViews()
    
    XCTAssertNil(view.placeholderImageView)
  }
  
  // MARK: - Prepare for reuse
  
  func testPrepareForReuse_removesImageView() {
    settings.placeholderImage = UIImage()
    let image = createImage67px()
    view.show(image: image, settings: settings)
    
    view.prepareForReuse()
    
    XCTAssertNil(view.imageView)
    XCTAssertNil(view.placeholderImageView)
  }
  
  func testPrepareForReuse_cancelCurrentDownload() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    let imageView = UIImageView()
    view.remoteImage = AukRemoteImage()
    view.remoteImage?.setup("http://site.com/auk.jpg", imageView: imageView,
                            placeholderImageView: nil, settings: settings)
    
    // Request image download
    imageView.moa.url = "http://site.com/auk.jpg"
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.first!.url)
    
    view.prepareForReuse()
    
    XCTAssert(simulator.downloaders.first!.cancelled)
    XCTAssert(imageView.moa.url == nil)
    XCTAssertNil(view.remoteImage)
  }
}
