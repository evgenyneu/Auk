import UIKit

/**

Collection of static functions that help managing the scroll view content.

*/
struct AukScrollViewContent {
  
  /**

  - returns: Array of scroll view pages.
  
  */
  static func aukPages(scrollView: UIScrollView) -> [AukPage] {
    return scrollView.subviews.filter { $0 is AukPage }.map { $0 as! AukPage }
  }
  
  /**
  
  Creates Auto Layout constraints for positioning the page view inside the scroll view.
  
  */
  static func layout(scrollView: UIScrollView) {
    let pages = aukPages(scrollView)

    for (index, page) in pages.enumerate() {
      
      // Delete current constraints by removing the view and adding it back to its superview
      page.removeFromSuperview()
      scrollView.addSubview(page)
      
      page.translatesAutoresizingMaskIntoConstraints = false
      
      // Make page size equal to the scroll view size
      iiAutolayoutConstraints.equalSize(page, viewTwo: scrollView, constraintContainer: scrollView)
      
      // Stretch the page vertically to fill the height of the scroll view
      iiAutolayoutConstraints.fillParent(page, parentView: scrollView, margin: 0, vertically: true)
      
      if index == 0 {
        // Align the leading edge of the first page to the leading edge of the scroll view.
        iiAutolayoutConstraints.alignSameAttributes(page, toItem: scrollView,
          constraintContainer: scrollView, attribute: NSLayoutAttribute.Leading, margin: 0)
      }
      
      if index == pages.count - 1 {
        // Align the trailing edge of the last page to the trailing edge of the scroll view.
        iiAutolayoutConstraints.alignSameAttributes(page, toItem: scrollView,
          constraintContainer: scrollView, attribute: NSLayoutAttribute.Trailing, margin: 0)
      }
    }
    
    // Align page next to each other
    iiAutolayoutConstraints.viewsNextToEachOther(pages, constraintContainer: scrollView,
      margin: 0, vertically: false)
    
    scrollView.layoutIfNeeded()
  }
}