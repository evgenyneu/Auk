import UIKit

/**

Scrolling code.

*/
struct AukScrollTo {
  static func scrollTo(scrollView: UIScrollView, pageIndex: Int, animated: Bool,
    numberOfPages: Int) {
      
    let pageWidth = scrollView.bounds.size.width
    scrollTo(scrollView, pageIndex: pageIndex, pageWidth: pageWidth, animated: animated,
      numberOfPages: numberOfPages)
  }
  
  static func scrollTo(scrollView: UIScrollView, pageIndex: Int, pageWidth: CGFloat,
    animated: Bool, numberOfPages: Int) {
      
    let offsetX = CGFloat(pageIndex) * pageWidth
    var offset = CGPoint(x: offsetX, y: 0)
      
    let maxOffset = CGFloat(numberOfPages - 1) * pageWidth
      
    // Prevent overscrolling to the right
    if offset.x > maxOffset { offset.x = maxOffset }
      
    // Prevent overscrolling to the left
    if offset.x < 0 { offset.x = 0 }

    scrollView.setContentOffset(offset, animated: animated)
  }
  
  static func scrollToNextPage(scrollView: UIScrollView, cycle: Bool, animated: Bool,
    currentPageIndex: Int, numberOfPages: Int) {
      
    var pageIndex = currentPageIndex + 1
      
    if pageIndex >= numberOfPages {
      if cycle {
        pageIndex = 0
      } else {
        return
      }
    }
    
    scrollTo(scrollView, pageIndex: pageIndex, animated: animated, numberOfPages: numberOfPages)
  }
  
  static func scrollToPreviousPage(scrollView: UIScrollView, cycle: Bool, animated: Bool,
    currentPageIndex: Int, numberOfPages: Int) {
    
    var pageIndex = currentPageIndex - 1
      
    if pageIndex < 0 {
      if cycle {
        pageIndex = numberOfPages - 1
      } else {
        return
      }
    }
    
    scrollTo(scrollView, pageIndex: pageIndex, animated: animated, numberOfPages: numberOfPages)
  }
}