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
  
  func testDownloadImage() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage()
    
    let image = uiImageFromFile("96px.png")
    simulator.respondWithImage(image)
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.jpg", simulator.downloaders.first!.url)
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
}