import UIKit
import XCTest
import moa

class AukRemoteImageTests: XCTestCase {
  
  var obj: AukRemoteImage!
  var imageView: UIImageView!
  
  override func setUp() {
    super.setUp()
    
    imageView = UIImageView()
    obj = AukRemoteImage(url: "http://site.com/auk.jpg", imageView: imageView)    
  }
  
  override func tearDown() {
    super.tearDown()
    
    MoaSimulator.clear()
  }
  
  // MARK: - Download image
  
  func testDownloadImage() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage()
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.first!.url)
    
    let image = uiImageFromFile("96px.png")
    simulator.respondWithImage(image)
    
    XCTAssertEqual(96, imageView.image!.size.width)
  }
  
  func testDownloadImage_downloadOnlyOnce_whenCalledMultipleTimes() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage()
    obj.downloadImage()
    obj.downloadImage()
    
    let image = uiImageFromFile("96px.png")
    simulator.respondWithImage(image)
    
    XCTAssertEqual(1, simulator.downloaders.count)
  }
  
  // MARK: - Cancel image download
  
  func testCancelDownload() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    // Request image download
    imageView.moa.url = "http://site.com/auk.jpg"
    
    obj.cancelDownload()
    
    XCTAssert(simulator.downloaders.first!.cancelled)
    XCTAssert(imageView.moa.url == nil)
  }
  
  func testCancelDownload_andStartAgain() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    // Request image download
    imageView.moa.url = "http://site.com/auk.jpg"
    
    obj.cancelDownload()
    obj.downloadImage()

    XCTAssertEqual(2, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.last!.url)
    XCTAssertFalse(simulator.downloaders.last!.cancelled)
    
    let image = uiImageFromFile("67px.png")
    simulator.respondWithImage(image)
    
    XCTAssertEqual(67, imageView.image!.size.width)
  }
}