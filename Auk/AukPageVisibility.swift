import UIKit

/**

Helper functions that tell if the scroll view page is currently visible to the user.

*/
struct AukPageVisibility {
  /**
  
  Check if the given page is currently visible to user.
  
  - parameter scrollView: Scroll view containing the page.
  - parameter page: A scroll view page which visibility will be checked.
  
  - returns: True if the page is visible to the user.
  
  */
  static func isVisible(_ scrollView: UIScrollView, page: AukPage) -> Bool {
    return scrollView.bounds.intersects(page.frame)
  }
  
  /**
  
  Tells if the page is way out of sight. This is done to prevent cancelling download of the image for the page that is not very far out of sight.
  
  - parameter scrollView: Scroll view containing the page.
  - parameter page: A scroll view page which visibility will be checked.
  
  - returns: True if the page is visible to the user.
  
  */
  static func isFarOutOfSight(_ scrollView: UIScrollView, page: AukPage) -> Bool {
    let parentRectWithIncreasedHorizontalBounds = scrollView.bounds.insetBy(dx: -50, dy: 0)
    return !parentRectWithIncreasedHorizontalBounds.intersects(page.frame)
  }
  
  /**
  
  Go through all the scroll view pages and tell them if they are visible or out of sight.
  The pages, in turn, if they are visible start the download of the image
  or cancel the download if they are out of sight.
  
  - parameter scrollView: Scroll view with the pages.

  */
  static func tellPagesAboutTheirVisibility(_ scrollView: UIScrollView,
                                            settings: AukSettings,
                                            currentPageIndex: Int) {
    
    let pages = AukScrollViewContent.aukPages(scrollView)

    for (index, page) in pages.enumerated() {
      if isVisible(scrollView, page: page) {
        page.visibleNow(settings)
      } else {
        if abs(index - currentPageIndex) <= settings.preloadRemoteImagesAround {
          // Preload images for the pages around the current page
          page.visibleNow(settings)
        } else {
          /*
          The image is not visible to user and is not preloaded - cancel its download.
           
          Now, this is a bit nuanced so let me explain. When we scroll into a new page we sometimes see a little bit of the next page. The scroll view animation overshoots a little bit to show the next page and then slides back to the current page. This is probably done on purpose for more natural spring bouncing effect.

          When the scroll view overshoots and shows the next page, we call `isVisible` on it and it starts downloading its image. But because scroll view bounces back in a moment the page becomes invisible again very soon. If we just call `outOfSightNow()` the next page download will be canceled even though it has just been started. That is probably not very efficient use of network, so we call `isFarOutOfSight` function to check if the next page is way out of sight (and not just a little bit). If the page is out of sight but just by a little margin we still let it download the image.

          */
          if isFarOutOfSight(scrollView, page: page) {
            page.outOfSightNow()
          }
        }
      }
    }
  }
}
