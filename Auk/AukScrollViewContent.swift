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
  static func layout(scrollView: UIScrollView, pageSize: CGSize, pageIndex: Int) {
    updateContentSize(scrollView, pageSize: pageSize)
    positionSubviews(scrollView, pageSize: pageSize)
    updateContentOffset(scrollView, pageSize: pageSize, pageIndex: pageIndex)
  }
  
  /**
  
  Update content size of the scroll view so it can fit all the subviews.  The width of each subview equals the width of the scroll view.
  
  */
  static func updateContentSize(scrollView: UIScrollView, pageSize: CGSize) {
    let subviews = aukViews(scrollView)
    
    let contentWidth = CGFloat(subviews.count) * pageSize.width
    let contentHeight = pageSize.height
    
    scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
  }
  
  /**
  
  Positions all the AukView views inside the scroll view.
  
  */
  static func positionSubviews(scrollView: UIScrollView, pageSize: CGSize) {
    let subviews = aukViews(scrollView)
    
    var xOrigin: CGFloat = 0
    
    for subview in subviews {
      let origin = CGPoint(x: xOrigin, y: 0)
      positionSingleSubview(scrollView, subview: subview, origin: origin, pageSize: pageSize)
      xOrigin += pageSize.width
    }
  }
  
  /**
  
  Positions the single subview at the given origin. Sets the width of the subview to be equal to the width of the scroll view.
  
  */
  static func positionSingleSubview(scrollView: UIScrollView, subview: UIView,
    origin: CGPoint, pageSize: CGSize) {
      
    subview.frame.origin = origin
    subview.frame.size = pageSize
  }
  
  /// Updates the content offset based on the given size of the page and its index
  static func updateContentOffset(scrollView: UIScrollView, pageSize: CGSize, pageIndex: Int) {
    scrollView.contentOffset.x = CGFloat(pageIndex) * pageSize.width
  }
  
  /**
  
  Hides all the views except the view with given index. This function is called before the size change starts.
  
  */
  static func hideAllViewsExceptOne(scrollView: UIScrollView, pageIndex: Int) {
    let subviews = aukViews(scrollView)
    
    for (index, subview) in enumerate(subviews) {
      if index != pageIndex {
        subview.hidden = true
      }
    }
  }
  
  /**
  
  Shows all the views. This function is called after the size change finishes.
  
  */
  static func showViews(scrollView: UIScrollView) {
    let subviews = aukViews(scrollView)
    
    for subview in subviews {
      subview.hidden = false
    }
  }
}