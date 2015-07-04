import UIKit

/**

Scrolling code.

*/
struct AukScrollTo {
  static func scrollTo(scrollView: UIScrollView, pageIndex: Int, animated: Bool) {
    let pageWidth = scrollView.bounds.size.width
    scrollTo(scrollView, pageIndex: pageIndex, pageWidth: pageWidth, animated: animated)
  }
  
  static func scrollTo(scrollView: UIScrollView, pageIndex: Int, pageWidth: CGFloat, animated: Bool) {
    let offsetX = CGFloat(pageIndex) * pageWidth
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
    
    scrollTo(scrollView, pageIndex: pageIndex, animated: true)
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
    
    scrollTo(scrollView, pageIndex: pageIndex, animated: true)
  }
}