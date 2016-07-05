import XCTest
import UIKit
@testable import Auk

class AukInterfaceNumberOfPagesTests: XCTestCase {
  
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
    
  func testNumberOfPage() {
    // Show 2 images
    // -------------
    
    let image = createImage96px()
    auk.show(image: image)
    auk.show(image: image)
    
    XCTAssertEqual(2, auk.numberOfPages)
  }
}

