import UIKit

/**

Starts and cancels the auto scrolling.

*/
struct AukAutoscroll {
  var autoscrollTimer: MoaTimer?
  
  mutating func startAutoScroll(scrollView: UIScrollView, delaySeconds: Double,
    forward: Bool, cycle: Bool, animated: Bool, auk: AukInterface) {
      
    // Cancel the previous timer.
    // Simply creating another one will NOT cancel the previous timer because the closure will be capturing the timer's instance.
    autoscrollTimer?.cancel()
      
    autoscrollTimer = MoaTimer.runAfter(delaySeconds, repeats: true) { timer in
      if forward {
        AukScrollTo.scrollToNextPage(scrollView, cycle: cycle,
          animated: animated, currentPageIndex: auk.currentPageIndex,
          numberOfPages: auk.numberOfPages)
      } else {
        AukScrollTo.scrollToPreviousPage(scrollView, cycle: cycle,
          animated: animated, currentPageIndex: auk.currentPageIndex,
          numberOfPages: auk.numberOfPages)
      }
    }
  }
  
  mutating func stopAutoScroll() {
    autoscrollTimer?.cancel()
  }
}
