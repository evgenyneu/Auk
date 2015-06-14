import UIKit
import XCTest

class GreatAukTests: XCTestCase {
  
  var scrollView: UIScrollView!
  var theAuk: TheAuk!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    theAuk = TheAuk(scrollView: scrollView)
  }
  
  func testShowLocalImage() {
    let image = uiImageFromFile("67px.png")
    theAuk.show(image: image)
    
    XCTAssertEqual(1, theAukViews(scrollView).count)
  }
  
  
  func testShowRemoteImage() {
    theAuk.show(url: "http://site.com/image.png")
  }
}
