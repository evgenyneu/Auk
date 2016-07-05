import UIKit

/**

Collection of static functions that help managing the scroll view content.

*/
struct AukScrollViewContent {
  
  /**

  - returns: Array of scroll view pages.
  
  */
  static func aukPages(_ scrollView: UIScrollView) -> [AukPage] {
    return scrollView.subviews.filter { $0 is AukPage }.map { $0 as! AukPage }
  }
  
  /**
 
  - returns: Page at index. Returns nil if index is out of bounds.
 
  */
  static func page(atIndex index: Int, scrollView: UIScrollView) -> AukPage? {
    let pages = aukPages(scrollView)
    if index < 0 { return nil }
    if index >= pages.count { return nil }
    return pages[index]
  }
  
  /**
  
  Creates Auto Layout constraints for positioning the page view inside the scroll view.
   
  - parameter scrollView: scroll view to layout.

  - parameter animated: will animate the layout if true. Default value: false.
   
  - parameter animationDurationInSeconds: duration of the layout animation. Ignored if `animated` parameter is false.

  - parameter completion: function that is called when layout animation finishes. Called immediately if not animated.
  
  */
  static func layout(_ scrollView: UIScrollView, animated: Bool = false,
                     animationDurationInSeconds: Double = 0.2, completion: (()->())? = nil) {
    
    let pages = aukPages(scrollView)

    for (index, page) in pages.enumerated() {
      
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
          constraintContainer: scrollView, attribute: NSLayoutAttribute.leading, margin: 0)
      }
      
      if index == pages.count - 1 {
        // Align the trailing edge of the last page to the trailing edge of the scroll view.
        iiAutolayoutConstraints.alignSameAttributes(page, toItem: scrollView,
          constraintContainer: scrollView, attribute: NSLayoutAttribute.trailing, margin: 0)
      }
    }
    
    // Align page next to each other
    iiAutolayoutConstraints.viewsNextToEachOther(pages, constraintContainer: scrollView,
      margin: 0, vertically: false)
    
    if animated {
      iiAnimator.animator.animate(name: "layoutIfNeeded", withDuration: animationDurationInSeconds,
        animations: {
          scrollView.layoutIfNeeded()
        },
        completion: { _ in
          completion?()
        }
      )
    } else {
      scrollView.layoutIfNeeded()
      completion?()
    }
  }
}
