import UIKit
import XCTest
import moa

class AukScrollToTests: XCTestCase {
  
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
  
  func testScrollTo() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.scrollTo(2, animated: false)
    XCTAssertEqual(240, scrollView.contentOffset.x)
  }
  
  func testScrollTo_noPages() {
    let image = uiImageFromFile("96px.png")
    
    auk.scrollTo(0, animated: false)
    XCTAssertEqual(0, scrollView.contentOffset.x)
  }
  
  func testScrollTo_preventOverscrollingToTheRight() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.scrollTo(3, animated: false)
    XCTAssertEqual(240, scrollView.contentOffset.x)
  }
  
  func testScrollTo_preventOverscrollingToTheLeft() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    auk.scrollTo(-1, animated: false)
    XCTAssertEqual(0, scrollView.contentOffset.x)
  }
}