import UIKit
import XCTest

class AukViewTests: XCTestCase {
  
  var view: AukView!
  
  override func setUp() {
    super.setUp()
    
    view = AukView()
  }
  
  func testShowImage() {
    let image = uiImageFromFile("67px.png")

    view.show(image: image)
    
    XCTAssertEqual(67, view.imageView!.image!.size.width)
  }
}