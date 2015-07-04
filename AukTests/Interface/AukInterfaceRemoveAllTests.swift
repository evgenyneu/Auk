import XCTest
import UIKit

class AukInterfaceRemoveAllTests: XCTestCase {
  
  var scrollView: UIScrollView!
  var auk: AukInterface!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 120, height: 90)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
    
    auk = Auk(scrollView: scrollView)
  }
  
  func testRemoveImages() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.removeAll()
    
    XCTAssertEqual(0, aukPages(scrollView).count)
    XCTAssertEqual(0, auk.numberOfPages)
    
    let aukObj = auk as! Auk
    XCTAssertEqual(0, aukObj.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, aukObj.pageIndicatorContainer!.pageControl!.currentPage)
  }
}
