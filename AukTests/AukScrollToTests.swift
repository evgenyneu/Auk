import XCTest
import moa

class AukScrollToTests: XCTestCase {
  
  var scrollView: UIScrollView!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 120, height: 90)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
  }
  
  
}