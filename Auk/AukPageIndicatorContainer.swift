import UIKit

/// View containing a UIPageControl object that shows the dots for present pages.
final class AukPageIndicatorContainer: UIView {
  weak var pageControl: UIPageControl? {
    get {
      if subviews.count == 0 { return nil }
      return subviews[0] as? UIPageControl
    }
  }
  
  func setup(settings: AukSettings, scrollView: UIScrollView) {
    if let superview = scrollView.superview {
      superview.addSubview(self)
    }
    
    styleContainer(settings)
    AukPageIndicatorContainer.layoutContainer(self, settings: settings, scrollView: scrollView)
    
    let pageControl = createPageControl()
    AukPageIndicatorContainer.layoutPageControl(pageControl, superview: self, settings: settings)
  }
  
  private func styleContainer(settings: AukSettings) {
    backgroundColor = settings.pageControl.backgroundColor
    layer.cornerRadius = CGFloat(settings.pageControl.cornerRadius)
  }
  
  private static func layoutContainer(pageIndicatorContainer: AukPageIndicatorContainer,
    settings: AukSettings, scrollView: UIScrollView) {
      
    if let superview = pageIndicatorContainer.superview {
      pageIndicatorContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        
      // Align bottom of the page view indicator with the bottom of the scroll view
      iiAutolayoutConstraints.alignSameAttributes(pageIndicatorContainer, toItem: scrollView,
        constraintContainer: superview, attribute: NSLayoutAttribute.Bottom,
        margin: CGFloat(-settings.pageControl.marginToScrollViewBottom))
      
      // Center the page view indicator horizontally in relation to the scroll view
      iiAutolayoutConstraints.alignSameAttributes(pageIndicatorContainer, toItem: scrollView,
        constraintContainer: superview, attribute: NSLayoutAttribute.CenterX, margin: 0)
    }
  }
  
  private func createPageControl() -> UIPageControl {
    let pageControl = UIPageControl()
    pageControl.numberOfPages = 5
    addSubview(pageControl)
    return pageControl
  }
  
  private static func layoutPageControl(pageControl: UIPageControl, superview: UIView, settings: AukSettings) {
    pageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    iiAutolayoutConstraints.fillParent(pageControl, parentView: superview,
      margin: settings.pageControl.innerPadding.width, vertically: false)
    
    iiAutolayoutConstraints.fillParent(pageControl, parentView: superview,
      margin: settings.pageControl.innerPadding.height, vertically: true)
  }
}
