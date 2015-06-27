import UIKit
import XCTest
import moa

class AukPageTests: XCTestCase {
  
  var view: AukPage!
  var settings = AukSettings()
  
  override func setUp() {
    super.setUp()
    view = AukPage()
  }
  
  override func tearDown() {
    super.tearDown()
    
    MoaSimulator.clear()
  }
  
  // MARK: - Show image
  
  func testShowImage() {
    let image = uiImageFromFile("67px.png")

    view.show(image: image, settings: settings)
    
    XCTAssertEqual(67, view.imageView!.image!.size.width)
  }
  
  func testShowImage_useContentMode() {
    settings.contentMode = UIViewContentMode.TopRight
    let image = uiImageFromFile("67px.png")
    view.show(image: image, settings: settings)
    XCTAssertEqual(UIViewContentMode.TopRight.rawValue, view.imageView!.contentMode.rawValue)
  }
  
  // MARK: - Show image by url

  func testShowUrl() {
    view.show(url: "http://site.com/auk.jpg", settings: settings)
    
    XCTAssertEqual("http://site.com/auk.jpg", view.remoteImage!.url)
  }
  
  func testShowUrl_setup() {
    view.show(url: "http://site.com/auk.jpg", settings: settings)
    
    XCTAssert(view.imageView != nil)
  }
  
  // MARK: - Visible now
  
  func testVisibleNow() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    let imageView = UIImageView()
    
    view.remoteImage = AukRemoteImage(url: "http://site.com/auk.jpg", imageView: imageView)
    
    view.visibleNow()
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.first!.url)
    
    let image = uiImageFromFile("35px.jpg")
    simulator.respondWithImage(image)
    
    XCTAssertEqual(35, imageView.image!.size.width)
  }
  
  func testVisibleNow_whenCalledTwiceDownloadOnlyOnce() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    let imageView = UIImageView()
    
    view.remoteImage = AukRemoteImage(url: "http://site.com/auk.jpg", imageView: imageView)
    
    view.visibleNow()
    view.visibleNow()
    
    let image = uiImageFromFile("35px.jpg")
    simulator.respondWithImage(image)
    
    XCTAssertEqual(1, simulator.downloaders.count)
  }
  
  // MARK: - Out of sight now
  
  func testOutOfSightNow_cancelCurrentImageDownload() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    let imageView = UIImageView()
    view.remoteImage = AukRemoteImage(url: "http://site.com/auk.jpg", imageView: imageView)
    imageView.moa.url = "http://site.com/auk.jpg"
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.first!.url)

    view.outOfSightNow()
    
    XCTAssert(simulator.downloaders.first!.cancelled)
    XCTAssert(imageView.moa.url == nil)
  }


}