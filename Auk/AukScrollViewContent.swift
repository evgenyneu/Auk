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
  static func layout(scrollView: UIScrollView) {
    updateContentSize(scrollView)
  }
  
  /**
  
  Update content size of the scroll view so it can fit all the subviews.  The width of each subview equals the width of the scroll view.
  
  */
  static func updateContentSize(scrollView: UIScrollView) {
    let subviews = aukViews(scrollView)
    
    let contentWidth = CGFloat(subviews.count) * scrollView.bounds.width
    let contentHeight = scrollView.bounds.height
    
    scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
  }
  
  /**
  
  Positions the single subview at the given origin. Sets the width of the subview to be equal to the width of the scroll view.
  
  */
  static func positionSingleSubview(scrollView: UIScrollView, subview: UIView, origin: CGPoint) {
    subview.frame.origin = origin
    subview.frame.size = scrollView.bounds.size
  }
  
  /**
  
  Positions all the AukViews inside the scroll view.
  
  */
  static func positionSingleSubview(scrollView: UIScrollView) {
    
  }
}