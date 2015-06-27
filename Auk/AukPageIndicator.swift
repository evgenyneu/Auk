import UIKit

/// View containing a UIPageControl object that shows the dots for present pages.
final class AukPageIndicator: UIView {
  weak var pageControl: UIPageControl? {
    get {
      if subviews.count == 0 { return nil }
      return subviews[0] as? UIPageControl
    }
  }
  
  func setup(settings: AukSettings) {
    createPageControl(settings)
  }
  
  private func createPageControl(settings: AukSettings) {
    let pageControl = UIPageControl()
    addSubview(pageControl)
    
    pageControl.layer.cornerRadius = CGFloat(settings.pageControl.cornerRadius)
  }
}
