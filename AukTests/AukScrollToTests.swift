import XCTest
@testable import Auk

class AukScrollToTests: XCTestCase {
  var scrollView: UIScrollView!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 120, height: 90)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
  }
  
  // MARK: - Content offset for page
  
  func testContentOffsetForPage() {
    var result = AukScrollTo.contentOffsetForPage(0, pageWidth: 120, numberOfPages: 3,
      scrollView: scrollView)
    
    XCTAssertEqual(0, result)
    
    result = AukScrollTo.contentOffsetForPage(0, pageWidth: 120, numberOfPages: 0,
      scrollView: scrollView)
    
    XCTAssertEqual(0, result)
    
    result = AukScrollTo.contentOffsetForPage(2, pageWidth: 120, numberOfPages: 3,
      scrollView: scrollView)
    
    XCTAssertEqual(240, result)
  }
  
  func testContentOffsetForPage_OverscrolledToRight() {
    let result = AukScrollTo.contentOffsetForPage(3, pageWidth: 120, numberOfPages: 3,
      scrollView: scrollView)
    
    XCTAssertEqual(240, result)
  }
  
  func testContentOffsetForPage_OverscrolledToLeft() {
    let result = AukScrollTo.contentOffsetForPage(-1, pageWidth: 120, numberOfPages: 2,
      scrollView: scrollView)
    
    XCTAssertEqual(0, result)
  }
  
  func testContentOffsetForPage_rightToLeft() {
    if #available(iOS 9.0, *) {
      scrollView.semanticContentAttribute = .ForceRightToLeft

      var result = AukScrollTo.contentOffsetForPage(0, pageWidth: 120, numberOfPages: 3,
        scrollView: scrollView)
      
      XCTAssertEqual(240, result)
      
      result = AukScrollTo.contentOffsetForPage(0, pageWidth: 120, numberOfPages: 2,
        scrollView: scrollView)
      
      XCTAssertEqual(120, result)
      
      result = AukScrollTo.contentOffsetForPage(0, pageWidth: 120, numberOfPages: 0,
        scrollView: scrollView)
      
      XCTAssertEqual(0, result)
      
      
      result = AukScrollTo.contentOffsetForPage(1, pageWidth: 120, numberOfPages: 3,
        scrollView: scrollView)
      
      XCTAssertEqual(120, result)
      
      result = AukScrollTo.contentOffsetForPage(2, pageWidth: 120, numberOfPages: 3,
        scrollView: scrollView)
      
      XCTAssertEqual(0, result)
    }
  }
  
  func testContentOffsetForPage_OverscrolledToRight_rightToLeft() {
    if #available(iOS 9.0, *) {
      scrollView.semanticContentAttribute = .ForceRightToLeft
      
      let result = AukScrollTo.contentOffsetForPage(3, pageWidth: 120, numberOfPages: 3,
        scrollView: scrollView)
      
      XCTAssertEqual(0, result)
    }
  }
  
  func testContentOffsetForPage_OverscrolledToLeft_rightToLeft() {
    if #available(iOS 9.0, *) {
      scrollView.semanticContentAttribute = .ForceRightToLeft
      
      let result = AukScrollTo.contentOffsetForPage(-1, pageWidth: 120, numberOfPages: 2,
        scrollView: scrollView)
      
      XCTAssertEqual(120, result)
    }
  }
  
  // MARK: - Scroll to
  
  func testScrollTo() {
    AukScrollTo.scrollTo(scrollView, pageIndex: 1, pageWidth: 120, animated: false, numberOfPages: 2)
    
    XCTAssertEqual(120, scrollView.contentOffset.x)
  }
  
  func testScrollTo_rightToLeft() {
    if #available(iOS 9.0, *) {
      scrollView.semanticContentAttribute = .ForceRightToLeft
      
      AukScrollTo.scrollTo(scrollView, pageIndex: 1, pageWidth: 120, animated: false, numberOfPages: 2)
      
      XCTAssertEqual(0, scrollView.contentOffset.x)
    }
  }
}