import UIKit

/**

Helper functions that tall if the scroll view page is currently visible to the user.

*/
struct AukPageVisibility {
  static func isVisible(scrollView: UIScrollView, page: AukPage) -> Bool {
    return CGRectIntersectsRect(scrollView.bounds, page.frame)
  }
}