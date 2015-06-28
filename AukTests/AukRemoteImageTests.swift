import UIKit
import XCTest
import moa

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
    obj.setup("http://site.com/auk.jpg", imageView: imageView, settings: settings)
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage()
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.first!.url)
    
    simulator.respondWithImage(uiImageFromFile("96px.png"))
    
    XCTAssertEqual(96, imageView.image!.size.width)
  }
  
  func testDownloadImage_downloadOnlyOnce_whenCalledMultipleTimes() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView, settings: settings)
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage()
    obj.downloadImage()
    obj.downloadImage()
    
    simulator.respondWithImage(uiImageFromFile("96px.png"))
    
    XCTAssertEqual(1, simulator.downloaders.count)
  }
  
  // MARK: - Cancel image download
  
  func testCancelDownload() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView, settings: settings)
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    // Request image download
    imageView.moa.url = "http://site.com/auk.jpg"
    
    obj.cancelDownload()
    
    XCTAssert(simulator.downloaders.first!.cancelled)
    XCTAssert(imageView.moa.url == nil)
  }
  
  func testCancelDownload_andStartAgain() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView, settings: settings)
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    // Request image download
    imageView.moa.url = "http://site.com/auk.jpg"
    
    obj.cancelDownload()
    obj.downloadImage()

    XCTAssertEqual(2, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.last!.url)
    XCTAssertFalse(simulator.downloaders.last!.cancelled)
    
    simulator.respondWithImage(uiImageFromFile("67px.png"))
    
    XCTAssertEqual(67, imageView.image!.size.width)
  }
  
  func testDownloadImage_doNotDownloadImageThatHasBeenAlreadyDownloaded() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView, settings: settings)
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage()
    
    // Respond with image
    simulator.respondWithImage(uiImageFromFile("96px.png"))
    
    // Call download again
    obj.downloadImage()
    
    // Should not download the second time
    XCTAssertEqual(1, simulator.downloaders.count)
  }
  
  func testDownloadImage_doNotDownloadImageThatHasBeenAlreadyDownloadedAndCancelled() {
    obj.setup("http://site.com/auk.jpg", imageView: imageView, settings: settings)
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage()
    
    // Respond with image
    simulator.respondWithImage(uiImageFromFile("96px.png"))
    
    let didFinish = obj.didFinishDownload
    
    // Call cancelDownload (which does not actually cancel anything, because image has already been downloaded)
    obj.cancelDownload()
    
    // Call download again
    obj.downloadImage()
    
    // Should not download the second time
    XCTAssertEqual(1, simulator.downloaders.count)
  }
  
  // MARK: - Did receive image
  
  func testDidReceiveImage_markDownloadAsFinished() {
    XCTAssertFalse(obj.didFinishDownload)
    
    obj.didReceiveImageAsync(UIImage())
    
    XCTAssert(obj.didFinishDownload)
  }
  
  // MARK: - Show placeholder image before image is download
  
  func testShowPlaceholderImage() {
    
  }
}