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
    let subviews = aukViews(scrollView)

    for (index, subview) in enumerate(subviews) {
      
      // Delete current constraints by removing the view and adding it back to its superview
      subview.removeFromSuperview()
      scrollView.addSubview(subview)
      
      subview.setTranslatesAutoresizingMaskIntoConstraints(false)
      
      iiAutolayoutConstraints.equalSize(subview, viewTwo: scrollView, constraintContainer: scrollView)
      iiAutolayoutConstraints.fillParent(subview, parentView: scrollView, margin: 0, vertically: true)
      
      if index == 0 {
        iiAutolayoutConstraints.alignSameAttributes(subview, toItem: scrollView,
          constraintContainer: scrollView, attribute: NSLayoutAttribute.Left, margin: 0)
      }
      
      if index == subviews.count - 1 {
        iiAutolayoutConstraints.alignSameAttributes(subview, toItem: scrollView,
          constraintContainer: scrollView, attribute: NSLayoutAttribute.Right, margin: 0)
      }
    }
    
    iiAutolayoutConstraints.viewsNextToEachOther(subviews, constraintContainer: scrollView,
      margin: 0, vertically: false)
  }
  
  /// Updates the content offset based on the given size of the page and its index
  static func updateContentOffset(scrollView: UIScrollView, pageSize: CGSize, pageIndex: Int) {
    scrollView.contentOffset.x = CGFloat(pageIndex) * pageSize.width
  }
}