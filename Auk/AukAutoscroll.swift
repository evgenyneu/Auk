import UIKit

/**

Starts and cancels the auto scrolling.

*/
struct AukAutoscroll {
  var autoscrollTimer: MoaTimer?
  
  mutating func startAutoScroll(scrollView: UIScrollView, delaySeconds: Double,
    forward: Bool, cycle: Bool, animated: Bool, auk: AukInterface) {
      
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
}
