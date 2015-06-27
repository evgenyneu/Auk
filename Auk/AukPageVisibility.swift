import UIKit

/**

Helper functions that tell if the scroll view page is currently visible to the user.

*/
struct AukPageVisibility {
  /**
  
  Check if the given page is currently visible to user.
  
  :param: scrollView: Scroll view containing the page.
  :param: page: A scroll view page which visibility will be checked.
  
  :returns: True if the page is visible to the user.
  
  */
  static func isVisible(scrollView: UIScrollView, page: AukPage) -> Bool {
    let bounds3 = scrollView.bounds
    let frame3 = page.frame
    return CGRectIntersectsRect(scrollView.bounds, page.frame)
  }
  
  /**
  
  Goes through all the scroll view pages and tell them if they are visible or out of sight. The pages, in turn, if they are visible start the download of the image or cancel the download if they are out of sight.
  
  :param: scrollView: Scroll view with the pages.

  */
  static func tellPagesAboutTheirVisibility(scrollView: UIScrollView) {
    let pages = AukScrollViewContent.aukPages(scrollView)

    for page in pages {
      if isVisible(scrollView, page: page) {
        page.visibleNow()
      } else {
        page.outOfSightNow()
      }
    }
  }
}