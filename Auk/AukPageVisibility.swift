import UIKit

/**

Helper functions that tall if the scroll view page is currently visible to the user.

*/
struct AukPageVisibility {
  /**
  
  Check if the given page is currently visible to user.
  
  :param: scrollView: Scroll view containing the page.
  :param: page: A scroll view page which visibility will be checked.
  
  :returns: True if the page is visible to the user.
  
  */
  static func isVisible(scrollView: UIScrollView, page: AukPage) -> Bool {
    return CGRectIntersectsRect(scrollView.bounds, page.frame)
  }
}