import UIKit

/**

This delegate detects the scrolling event which is used for loading remote images when their superview becomes visible on screen.

*/
final class AukScrollViewDelegate: NSObject, UIScrollViewDelegate {
  /**
  
  If scroll view already has delegate it is preserved in this property and all the delegate calls are forwarded to it.
  
  */
  weak var delegate: UIScrollViewDelegate?
  
  var onScroll: (()->())?
  var onScrollByUser: (()->())?
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    onScroll?()
    delegate?.scrollViewDidScroll?(scrollView)
  }
  
  func scrollViewDidZoom(scrollView: UIScrollView) {
    delegate?.scrollViewDidZoom?(scrollView)
  }
  
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    delegate?.scrollViewWillBeginDragging?(scrollView)
    onScrollByUser?()
  }
  
  func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    delegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
  }
  
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
  }
  
  func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
    delegate?.scrollViewWillBeginDecelerating?(scrollView)
  }
  
  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    delegate?.scrollViewDidEndDecelerating?(scrollView)
  }
  
  func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
    delegate?.scrollViewDidEndScrollingAnimation?(scrollView)
  }
  
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return delegate?.viewForZoomingInScrollView?(scrollView)
  }
  
  func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
    delegate?.scrollViewWillBeginZooming?(scrollView, withView: view)
  }
  
  func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
    delegate?.scrollViewDidEndZooming?(scrollView, withView: view, atScale: scale)
  }
  
  func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
    return delegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
  }
  
  func scrollViewDidScrollToTop(scrollView: UIScrollView) {
    delegate?.scrollViewDidScrollToTop?(scrollView)
  }
}