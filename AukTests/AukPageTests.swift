import UIKit
import XCTest

class AukPageTests: XCTestCase {
  
  var view: AukPage!
  var settings = AukSettings()
  
  override func setUp() {
    super.setUp()
    view = AukPage()
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
}