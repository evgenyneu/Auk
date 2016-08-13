import XCTest
import moa
@testable import Auk

class AukRemoteImageTests: XCTestCase {
  
  var obj: AukRemoteImage!
  var imageView: UIImageView!
  var settings: AukSettings!

  override func setUp() {
    super.setUp()
    
    imageView = UIImageView()
    obj = AukRemoteImage()
    settings = AukSettings()
  }
  
  override func tearDown() {
    super.tearDown()
    
    MoaSimulator.clear()
  }
  
  // MARK: - Download image
  
  func testDownloadImage() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView,
      placeholderImageView: nil, settings: settings)
    
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage(settings)
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.first!.url)
    
    simulator.respondWithImage(createImage96px())
    
    XCTAssertEqual(96, imageView.image!.size.width)
  }
  
  func testDownloadImage_downloadOnlyOnce_whenCalledMultipleTimes() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView,
      placeholderImageView: nil, settings: settings)
    
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage(settings)
    obj.downloadImage(settings)
    obj.downloadImage(settings)
    
    simulator.respondWithImage(createImage96px())
    
    XCTAssertEqual(1, simulator.downloaders.count)
  }
  
  // MARK: - Cancel image download
  
  func testCancelDownload() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView,
      placeholderImageView: nil, settings: settings)
    
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    // Request image download
    imageView.moa.url = "http://site.com/auk.jpg"
    
    obj.cancelDownload()
    
    XCTAssert(simulator.downloaders.first!.cancelled)
    XCTAssert(imageView.moa.url == nil)
  }
  
  func testCancelDownload_andStartAgain() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView,
      placeholderImageView: nil, settings: settings)
    
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    // Request image download
    imageView.moa.url = "http://site.com/auk.jpg"
    
    obj.cancelDownload()
    obj.downloadImage(settings)

    XCTAssertEqual(2, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.last!.url)
    XCTAssertFalse(simulator.downloaders.last!.cancelled)
    
    simulator.respondWithImage(createImage67px())
    
    XCTAssertEqual(67, imageView.image!.size.width)
  }
  
  func testDownloadImage_doNotDownloadImageThatHasBeenAlreadyDownloaded() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView,
      placeholderImageView: nil, settings: settings)
    
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage(settings)
    
    // Respond with image
    simulator.respondWithImage(createImage96px())
    
    // Call download again
    obj.downloadImage(settings)
    
    // Should not download the second time
    XCTAssertEqual(1, simulator.downloaders.count)
  }
  
  func testDownloadImage_doNotDownloadImageThatHasBeenAlreadyDownloadedAndCancelled() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView,
      placeholderImageView: nil, settings: settings)
    
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage(settings)
    
    // Respond with image
    simulator.respondWithImage(createImage96px())
    
    // Call cancelDownload (which does not actually cancel anything, because image has already been downloaded)
    obj.cancelDownload()
    
    // Call download again
    obj.downloadImage(settings)
    
    // Should not download the second time
    XCTAssertEqual(1, simulator.downloaders.count)
  }
  
  // MARK: - Did receive image
  
  func testDidReceiveImage_markDownloadAsFinished() {
    XCTAssertFalse(obj.didFinishDownload)
    
    obj.didReceiveImageAsync(UIImage(), settings: settings)
    
    XCTAssert(obj.didFinishDownload)
  }
  
  // MARK: - Show placeholder image before image is download
  
  func testShowPlaceholderImage() {
    settings.placeholderImage = createImage35px()
    let placeholderImageView = UIImageView()

    obj.setup("http://site.com/auk.jpg", imageView: imageView,
      placeholderImageView: placeholderImageView, settings: settings)
    
    // Show placeholder
    XCTAssertEqual(35, placeholderImageView.image!.size.width)
  }
  
  // MARK: - Show error image
  
  func testShowErrorImage() {
    settings.errorImage = createImage35px()
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    let errorExpectation = expectation(description: "error expectation")
    
    obj.setup("http://site.com/auk.jpg", imageView: imageView, placeholderImageView: nil,
      settings: settings)
    
    // Request remote image
    obj.downloadImage(settings)
    
    simulator.respondWithError(nil, response: nil)
    
    iiQ.runAfterDelay(0.001) { errorExpectation.fulfill() }
    waitForExpectations(timeout: 1) { error in }
    
    // Show error image
    XCTAssertEqual(35, imageView.image!.size.width)
  }
}
