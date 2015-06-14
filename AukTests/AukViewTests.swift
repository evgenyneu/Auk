import UIKit
import XCTest

class AukViewTests: XCTestCase {
  
  var view: TheAukView!
  
  override func setUp() {
    super.setUp()
    
    view = TheAukView()
  }
  
  func testShowImage() {
    let image = uiImageFromFile("67px.png")

    view.show(image: image)
    
    XCTAssertEqual(67, view.imageView!.image!.size.width)
  }
}