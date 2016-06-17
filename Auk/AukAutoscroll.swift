import UIKit

/**

Starts and cancels the auto scrolling.

*/
struct AukAutoscroll {
  var autoscrollTimer: AutoCancellingTimer?
  
  mutating func startAutoScroll(_ scrollView: UIScrollView, delaySeconds: Double,
    forward: Bool, cycle: Bool, animated: Bool, auk: Auk) {
      
    // Assign the new instance of AutoCancellingTimer to autoscrollTimer
    // The previous instance deinitializes and cancels its timer.
      
    autoscrollTimer = AutoCancellingTimer(interval: delaySeconds, repeats: true) {
      guard let currentPageIndex = auk.currentPageIndex else { return }
      
      if forward {
        AukScrollTo.scrollToNextPage(scrollView, cycle: cycle,
          animated: animated, currentPageIndex: currentPageIndex,
          numberOfPages: auk.numberOfPages)
      } else {
        AukScrollTo.scrollToPreviousPage(scrollView, cycle: cycle,
          animated: animated, currentPageIndex: currentPageIndex,
          numberOfPages: auk.numberOfPages)
      }
    }
  }
  
  mutating func stopAutoScroll() {
    autoscrollTimer = nil // Cancels the timer on deinit
  }
}
