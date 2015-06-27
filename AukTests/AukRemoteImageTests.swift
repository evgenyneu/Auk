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
  
  func testDownload() {
    let simulator = MoaSimulator.simulate("auk.jpg")
    
    obj.downloadImage()
    
    let image = uiImageFromFile("96px.png")
    simulator.respondWithImage(image)
    
    XCTAssertEqual(96, imageView.image!.size.width)
  }
}