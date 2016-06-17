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
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    onScroll?()
    delegate?.scrollViewDidScroll?(scrollView)
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    delegate?.scrollViewDidZoom?(scrollView)
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    delegate?.scrollViewWillBeginDragging?(scrollView)
    onScrollByUser?()
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    delegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
  }
  
  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    delegate?.scrollViewWillBeginDecelerating?(scrollView)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    delegate?.scrollViewDidEndDecelerating?(scrollView)
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    delegate?.scrollViewDidEndScrollingAnimation?(scrollView)
  }
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return delegate?.viewForZooming?(in: scrollView)
  }
  
  func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    delegate?.scrollViewWillBeginZooming?(scrollView, with: view)
  }
  
  func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    delegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
  }
  
  func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
    return delegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
  }
  
  func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    delegate?.scrollViewDidScrollToTop?(scrollView)
  }
}
