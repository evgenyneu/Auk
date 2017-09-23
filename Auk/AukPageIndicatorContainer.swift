import UIKit

/// View containing a UIPageControl object that shows the dots for present pages.
final class AukPageIndicatorContainer: UIView {
  
  deinit {
    pageControl?.removeTarget(self, action: #selector(AukPageIndicatorContainer.didTapPageControl(_:)),
      for: UIControlEvents.valueChanged)
  }
  
  var didTapPageControlCallback: ((Int)->())?
  
  var pageControl: UIPageControl? {
    get {
      if subviews.count == 0 { return nil }
      return subviews[0] as? UIPageControl
    }
  }
  
  // Layouts the view, creates and layouts the page control
  func setup(_ settings: AukSettings, scrollView: UIScrollView) {    
    styleContainer(settings)
    AukPageIndicatorContainer.layoutContainer(self, settings: settings, scrollView: scrollView)
    
    let pageControl = createPageControl(settings)
    AukPageIndicatorContainer.layoutPageControl(pageControl, superview: self, settings: settings)
    
    updateVisibility()
  }
  
  // Update the number of pages showing in the page control
  func updateNumberOfPages(_ numberOfPages: Int) {
    pageControl?.numberOfPages = numberOfPages
    updateVisibility()
  }
  
  // Update the current page in the page control
  func updateCurrentPage(_ currentPageIndex: Int) {
    pageControl?.currentPage = currentPageIndex
  }
  
  private func styleContainer(_ settings: AukSettings) {
    backgroundColor = settings.pageControl.backgroundColor
    layer.cornerRadius = CGFloat(settings.pageControl.cornerRadius)
  }
  
  private static func layoutContainer(_ pageIndicatorContainer: AukPageIndicatorContainer,
    settings: AukSettings, scrollView: UIScrollView) {
      
    if let superview = pageIndicatorContainer.superview {
      pageIndicatorContainer.translatesAutoresizingMaskIntoConstraints = false
        
      // Align bottom of the page view indicator with the bottom of the scroll view
      iiAutolayoutConstraints.alignSameAttributes(pageIndicatorContainer, toItem: scrollView,
        constraintContainer: superview, attribute: NSLayoutAttribute.bottom,
        margin: CGFloat(-settings.pageControl.marginToScrollViewBottom))
      
      // Center the page view indicator horizontally in relation to the scroll view
      iiAutolayoutConstraints.alignSameAttributes(pageIndicatorContainer, toItem: scrollView,
        constraintContainer: superview, attribute: NSLayoutAttribute.centerX, margin: 0)
    }
  }
  
  private func createPageControl(_ settings: AukSettings) -> UIPageControl {
    let pageControl = UIPageControl()
    
    if #available(*, iOS 9.0) {
      // iOS 9+
    } else {
      // When using right-to-left language, flip the page control horizontally in iOS 8 and earlier.
      // That will make it highlight the rightmost dot for the first page.
      if RightToLeft.isRightToLeft(self) {
        pageControl.transform = CGAffineTransform(scaleX: -1, y: 1)
      }
    }
    
    pageControl.addTarget(self, action: #selector(AukPageIndicatorContainer.didTapPageControl(_:)),
      for: UIControlEvents.valueChanged)
    
    pageControl.pageIndicatorTintColor = settings.pageControl.pageIndicatorTintColor
    pageControl.currentPageIndicatorTintColor = settings.pageControl.currentPageIndicatorTintColor

    addSubview(pageControl)
    return pageControl
  }
  
  @objc func didTapPageControl(_ control: UIPageControl) {
    if let currentPage = pageControl?.currentPage {
      didTapPageControlCallback?(currentPage)
    }
  }
  
  private static func layoutPageControl(_ pageControl: UIPageControl, superview: UIView,
    settings: AukSettings) {
      
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    
    iiAutolayoutConstraints.fillParent(pageControl, parentView: superview,
      margin: settings.pageControl.innerPadding.width, vertically: false)
    
    iiAutolayoutConstraints.fillParent(pageControl, parentView: superview,
      margin: settings.pageControl.innerPadding.height, vertically: true)
  }
  
  private func updateVisibility() {
    if let pageControl = pageControl {
      self.isHidden = pageControl.numberOfPages < 2
    }
  }
}
