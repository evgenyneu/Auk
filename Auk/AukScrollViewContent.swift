import UIKit

/**

Collection of static functions that help managing the scroll view content.

*/
struct AukScrollViewContent {
  
  /**

  :returns: Array of AukView objects that are subviews of the given scroll view.
  
  */
  static func aukViews(scrollView: UIScrollView) -> [AukView] {
    return scrollView.subviews.filter { $0 is AukView }.map { $0 as! AukView }
  }
  
  /**
  
  Positions the content views of the scroll view next to each other. The width of each subview equals the width of the scroll view.
  
  */
  static func layout(scrollView: UIScrollView, size: CGSize, pageNumber: Int) {
    updateContentSize(scrollView, size: size)
    positionSubviews(scrollView, size: size)
    updateContentOffset(scrollView, size: size, pageNumber: pageNumber)
  }
  
  /**
  
  Update content size of the scroll view so it can fit all the subviews.  The width of each subview equals the width of the scroll view.
  
  */
  static func updateContentSize(scrollView: UIScrollView, size: CGSize) {
    let subviews = aukViews(scrollView)
    
    let contentWidth = CGFloat(subviews.count) * size.width
    let contentHeight = size.height
    
    scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
  }
  
  /**
  
  Positions all the AukView views inside the scroll view.
  
  */
  static func positionSubviews(scrollView: UIScrollView, size: CGSize) {
    let subviews = aukViews(scrollView)
    
    var xOrigin: CGFloat = 0
    
    for subview in subviews {
      let origin = CGPoint(x: xOrigin, y: 0)
      positionSingleSubview(scrollView, subview: subview, origin: origin, size: size)
      xOrigin += size.width
    }
  }
  
  /**
  
  Positions the single subview at the given origin. Sets the width of the subview to be equal to the width of the scroll view.
  
  */
  static func positionSingleSubview(scrollView: UIScrollView, subview: UIView,
    origin: CGPoint, size: CGSize) {
      
      subview.frame.origin = origin
      subview.frame.size = size
  }
  
  static func updateContentOffset(scrollView: UIScrollView, size: CGSize, pageNumber: Int) {
    scrollView.contentOffset.x = CGFloat(pageNumber) * size.width
  }
  
  static func hideAllViewsExceptCurrent(scrollView: UIScrollView, pageNumber: Int) {
    let subviews = aukViews(scrollView)
    
    for (index, subview) in enumerate(subviews) {
      if index != pageNumber {
        subview.hidden = true
      }
    }
  }
  
  static func showViews(scrollView: UIScrollView) {
    let subviews = aukViews(scrollView)
    
    for subview in subviews {
      subview.hidden = false
    }
  }
}