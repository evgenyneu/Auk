import XCTest
import UIKit
import moa
@testable import Auk

class AukInterfaceImagesTests: XCTestCase {
  
  var scrollView: UIScrollView!
  var auk: Auk!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 120, height: 90)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
    
    auk = Auk(scrollView: scrollView)
  }
  
  override func tearDown() {
    super.tearDown()
    
    MoaSimulator.clear()
  }
  
  func testReturnImages() {
    let simulator = MoaSimulator.simulate("site.com")
    auk.show(url: "http://site.com/moa.png")
    simulator.respondWithImage(createImage67px())
    
    auk.show(image: createImage35px())
    auk.show(image: createImage96px())
    
    // Returns three images
    // -------------
    
    XCTAssertEqual(3, auk.images.count)
    XCTAssertEqual(67, auk.images[0].size.width)
    XCTAssertEqual(35, auk.images[1].size.width)
    XCTAssertEqual(96, auk.images[2].size.width)
  }
  
  func testDoesNotReturnPlaceholderImage() {
    auk.settings.placeholderImage = createImage35px()
    _ = MoaSimulator.simulate("site.com")
    auk.show(url: "http://site.com/moa.png")
    
    XCTAssertEqual(0, auk.images.count)
  }
}
