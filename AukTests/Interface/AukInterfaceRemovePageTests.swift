import XCTest
import UIKit
@testable import Auk

class AukInterfaceRemovePageTests: XCTestCase {
  
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
  
  func testRemoveFirstImage() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    // Current page index is 0, and 4 pages
    
    // Remove first page
    auk.removePage(atIndex: 0)
    
    // Expect to have 3 pages left
    XCTAssertEqual(3, aukPages(scrollView).count)
    XCTAssertEqual(3, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (3 pages left, current page index 0)
    XCTAssertEqual(3, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Scroll to next page, so current page index should be 1
    auk.scrollToNextPage()
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: 0)

    // Expect to have 2 pages left
    XCTAssertEqual(2, aukPages(scrollView).count)
    XCTAssertEqual(2, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (2 pages left, current page index 1)
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: 0)

    // Expect to have 1 pages left
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(1, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (1 pages left, current page index 0)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
  }
  
  func testRemoveLastImage() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    // Current page index is 0, and 4 pages
    
    // Remove first page
    auk.removePage(atIndex: auk.numberOfPages - 1)
    
    // Expect to have 3 pages left
    XCTAssertEqual(3, aukPages(scrollView).count)
    XCTAssertEqual(3, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (3 pages left, current page index 0)
    XCTAssertEqual(3, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Scroll to next page, so current page index should be 1
    auk.scrollToNextPage()
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: auk.numberOfPages - 1)
    
    // Expect to have 2 pages left
    XCTAssertEqual(2, aukPages(scrollView).count)
    XCTAssertEqual(2, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (2 pages left, current page index 1)
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: auk.numberOfPages - 1)
    
    // Expect to have 1 pages left
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(1, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (1 pages left, current page index 0)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
  }
  
  func testRemoveCurrentImage() {
    // Layout scroll view
    // ---------------
    
    let superview = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: 300, height: 300)))
    superview.addSubview(scrollView)
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    auk.show(image: image)
    
    // Current page index is 0, and 4 pages
    
    // Remove first page
    auk.removePage(atIndex: auk.currentPageIndex!)
    
    // Expect to have 3 pages left
    XCTAssertEqual(3, aukPages(scrollView).count)
    XCTAssertEqual(3, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (3 pages left, current page index 0)
    XCTAssertEqual(3, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Scroll to next page, so current page index should be 1
    auk.scrollToNextPage()
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: auk.currentPageIndex!)
    
    // Expect to have 2 pages left
    XCTAssertEqual(2, aukPages(scrollView).count)
    XCTAssertEqual(2, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (2 pages left, current page index 1)
    XCTAssertEqual(2, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.currentPage)
    
    // Remove first page
    auk.removePage(atIndex: auk.currentPageIndex!)
    
    // Expect to have 1 pages left
    XCTAssertEqual(1, aukPages(scrollView).count)
    XCTAssertEqual(1, auk.numberOfPages)
    
    // Expect page control to be synced with scroll view (1 pages left, current page index 0)
    XCTAssertEqual(1, auk.pageIndicatorContainer!.pageControl!.numberOfPages)
    XCTAssertEqual(0, auk.pageIndicatorContainer!.pageControl!.currentPage)
  }
}
