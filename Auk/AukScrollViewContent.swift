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
  
  Creates Auto Layout constraints for positioning the page view inside the scroll view.
  
  */
  static func layout(scrollView: UIScrollView) {
    let subviews = aukViews(scrollView)

    for (index, subview) in enumerate(subviews) {
      
      // Delete current constraints by removing the view and adding it back to its superview
      subview.removeFromSuperview()
      scrollView.addSubview(subview)
      
      subview.setTranslatesAutoresizingMaskIntoConstraints(false)
      
      // Make page size equal to the scroll view size
      iiAutolayoutConstraints.equalSize(subview, viewTwo: scrollView, constraintContainer: scrollView)
      
      // Stretch the page vertically to fill the height of the scroll view
      iiAutolayoutConstraints.fillParent(subview, parentView: scrollView, margin: 0, vertically: true)
      
      if index == 0 {
        // Align the left edge of the first page to the left edge of the scroll view.
        iiAutolayoutConstraints.alignSameAttributes(subview, toItem: scrollView,
          constraintContainer: scrollView, attribute: NSLayoutAttribute.Left, margin: 0)
      }
      
      if index == subviews.count - 1 {
        // Align the right edge of the last page to the right edge of the scroll view.
        iiAutolayoutConstraints.alignSameAttributes(subview, toItem: scrollView,
          constraintContainer: scrollView, attribute: NSLayoutAttribute.Right, margin: 0)
      }
    }
    
    // Align page next to each other
    iiAutolayoutConstraints.viewsNextToEachOther(subviews, constraintContainer: scrollView,
      margin: 0, vertically: false)
  }
}