import UIKit
import XCTest

class AukPageTests: XCTestCase {
  
  var view: AukPage!
  var settings = AukSettings()
  
  override func setUp() {
    super.setUp()
    view = AukPage()
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