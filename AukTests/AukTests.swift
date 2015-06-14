import UIKit
import XCTest

class AukTests: XCTestCase {
  
  var scrollView: UIScrollView!
  var auk: Auk!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    auk = Auk(scrollView: scrollView)
  }
  
  func testShowLocalImage() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    XCTAssertEqual(1, aukViews(scrollView).count)
    XCTAssertEqual(96, firstAukImage(scrollView, index: 0)!.size.width)
  }
  
  func testShowRemoteImage() {
    auk.show(url: "http://site.com/image.png")
  }
}
