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
      
    let offsetX = contentOffsetForPage(pageIndex, pageWidth: pageWidth,
      numberOfPages: numberOfPages, scrollView: scrollView)
    
    let offset = CGPoint(x: offsetX, y: 0)
  
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
  
  /**

  Returns horizontal content offset needed to display the given page.
  Ensures that offset is within the content size.

  */
  static func contentOffsetForPage(pageIndex: Int, pageWidth: CGFloat,
    numberOfPages: Int, scrollView: UIView) -> CGFloat {
      
    // The index of the page that appears from left to right of the screen.
    // It is the same as pageIndex for left-to-right languages.
    let pageIndexFromTheLeft = RightToLeft.isRightToLeft(scrollView) ?
      numberOfPages - pageIndex - 1 : pageIndex
      
    var offsetX = CGFloat(pageIndexFromTheLeft) * pageWidth
      
    let maxOffset = CGFloat(numberOfPages - 1) * pageWidth
    
    // Prevent overscrolling to the right
    if offsetX > maxOffset { offsetX = maxOffset }
    
    // Prevent overscrolling to the left
    if offsetX < 0 { offsetX = 0 }
      
    return offsetX
  }
}