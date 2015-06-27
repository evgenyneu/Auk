import UIKit

final class AukScrollViewDelegate: NSObject, UIScrollViewDelegate {
  weak var delegate: UIScrollViewDelegate?
  
  var onScroll: (()->())?
  
  init(delegate: UIScrollViewDelegate) {
    super.init()
  
    self.delegate = delegate
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    onScroll?()
    delegate?.scrollViewDidScroll?(scrollView)
  }
  
  func scrollViewDidZoom(scrollView: UIScrollView) {
    delegate?.scrollViewDidZoom?(scrollView)
  }
  
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    delegate?.scrollViewWillBeginDragging?(scrollView)
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
  
  func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView!) {
    delegate?.scrollViewWillBeginZooming?(scrollView, withView: view)
  }
  
  func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
    delegate?.scrollViewDidEndZooming?(scrollView, withView: view, atScale: scale)
  }
  
  func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
    return delegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
  }
  
  func scrollViewDidScrollToTop(scrollView: UIScrollView) {
    delegate?.scrollViewDidScrollToTop?(scrollView)
  }
}