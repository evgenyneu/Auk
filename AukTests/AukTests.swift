import UIKit
import XCTest

class AukTests: XCTestCase {
  
  var scrollView: UIScrollView!
  var theAuk: TheAuk!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    theAuk = TheAuk(scrollView: scrollView)
  }
  
  func testShowLocalImage() {
    let image = uiImageFromFile("96px.png")
    theAuk.show(image: image)
    
    XCTAssertEqual(1, theAukViews(scrollView).count)
    XCTAssertEqual(96, firstAukImage(scrollView, index: 0)!.size.width)
  }
  
  func testShowRemoteImage() {
    theAuk.show(url: "http://site.com/image.png")
  }
}
