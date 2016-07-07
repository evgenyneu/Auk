import UIKit

/**

Scrolling code.

*/
struct AukScrollTo {
  static func scrollToPage(_ scrollView: UIScrollView, atIndex index: Int, animated: Bool,
    numberOfPages: Int) {
      
    let pageWidth = scrollView.bounds.size.width
    scrollToPage(scrollView, atIndex: index, pageWidth: pageWidth, animated: animated,
      numberOfPages: numberOfPages)
  }
  
  static func scrollToPage(_ scrollView: UIScrollView, atIndex index: Int, pageWidth: CGFloat,
    animated: Bool, numberOfPages: Int) {
      
    let offsetX = contentOffsetForPage(atIndex: index, pageWidth: pageWidth,
      numberOfPages: numberOfPages, scrollView: scrollView)
    
    let offset = CGPoint(x: offsetX, y: 0)
  
    scrollView.setContentOffset(offset, animated: animated)
  }
  
  static func scrollToNextPage(_ scrollView: UIScrollView, cycle: Bool, animated: Bool,
    currentPageIndex: Int, numberOfPages: Int) {
      
    var pageIndex = currentPageIndex + 1
      
    if pageIndex >= numberOfPages {
      if cycle {
        pageIndex = 0
      } else {
        return
      }
    }
    
    scrollToPage(scrollView, atIndex: pageIndex, animated: animated, numberOfPages: numberOfPages)
  }
  
  static func scrollToPreviousPage(_ scrollView: UIScrollView, cycle: Bool, animated: Bool,
    currentPageIndex: Int, numberOfPages: Int) {
    
    var pageIndex = currentPageIndex - 1
      
    if pageIndex < 0 {
      if cycle {
        pageIndex = numberOfPages - 1
      } else {
        return
      }
    }
    
    scrollToPage(scrollView, atIndex: pageIndex, animated: animated, numberOfPages: numberOfPages)
  }
  
  /**

  Returns horizontal content offset needed to display the given page.
  Ensures that offset is within the content size.

  */
  static func contentOffsetForPage(atIndex index: Int, pageWidth: CGFloat,
    numberOfPages: Int, scrollView: UIView) -> CGFloat {
      
    // The index of the page that appears from left to right of the screen.
    // It is the same as pageIndex for left-to-right languages.
    let pageIndexFromTheLeft = RightToLeft.isRightToLeft(scrollView) ?
      numberOfPages - index - 1 : index
      
    var offsetX = CGFloat(pageIndexFromTheLeft) * pageWidth
      
    let maxOffset = CGFloat(numberOfPages - 1) * pageWidth
    
    // Prevent overscrolling to the right
    if offsetX > maxOffset { offsetX = maxOffset }
    
    // Prevent overscrolling to the left
    if offsetX < 0 { offsetX = 0 }
      
    return offsetX
  }
}
