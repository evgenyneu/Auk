import UIKit
import XCTest

class AukViewTests: XCTestCase {
  
  var view: AukView!
  var settings = AukSettings()
  
  override func setUp() {
    super.setUp()
    view = AukView()
  }
  
  func testShowImage() {
    let image = uiImageFromFile("67px.png")

    view.show(image: image, settings: settings)
    
    XCTAssertEqual(67, view.imageView!.image!.size.width)
  }
  
  func testUseContentMode() {
    settings.contentMode = UIViewContentMode.TopRight
    let image = uiImageFromFile("67px.png")
    view.show(image: image, settings: settings)
    XCTAssertEqual(UIViewContentMode.TopRight.rawValue, view.imageView!.contentMode.rawValue)
  }
  
  
}