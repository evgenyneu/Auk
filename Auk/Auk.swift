import UIKit

final class Auk: AukInterface {
  private weak var scrollView: UIScrollView?
  var settings = AukSettings()
  var scrollViewDelegate = AukScrollViewDelegate()
  var pageIndicatorContainer: AukPageIndicatorContainer?
  var autoscrollTimer: MoaTimer?

  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
    
    scrollViewDelegate.onScroll = { [weak self] in
      self?.onScroll()
    }
    
    scrollViewDelegate.delegate = scrollView.delegate
    scrollView.delegate = scrollViewDelegate
  }
  
  func show(#image: UIImage) {
    setup()
    let page = createPage()
    page.show(image: image, settings: settings)
  }
  
  func show(#url: String) {
    setup()
    let page = createPage()
    page.show(url: url, settings: settings)
    
    if let scrollView = scrollView {
      AukPageVisibility.tellPagesAboutTheirVisibility(scrollView, settings: settings)
    }
  }
  
  func scrollTo(pageIndex: Int, animated: Bool) {
    if let scrollView = scrollView {
      AukScrollTo.scrollTo(scrollView, pageIndex: pageIndex, animated: animated)
    }
  }
  
  func scrollTo(pageIndex: Int, pageWidth: CGFloat, animated: Bool) {
    if let scrollView = scrollView {
      AukScrollTo.scrollTo(scrollView, pageIndex: pageIndex, pageWidth: pageWidth,
        animated: animated)
    }
  }
  
  func scrollToNextPage() {
    scrollToNextPage(cycle: true, animated: true)
  }
  
  func scrollToNextPage(#cycle: Bool, animated: Bool) {
    if let scrollView = scrollView {
      AukScrollTo.scrollToNextPage(scrollView, cycle: cycle, animated: animated,
        currentPageIndex: currentPageIndex, numberOfPages: numberOfPages)
    }
  }
  
  func scrollToPreviousPage() {
    scrollToPreviousPage(cycle: true, animated: true)
  }
  
  func scrollToPreviousPage(#cycle: Bool, animated: Bool) {
    if let scrollView = scrollView {
      AukScrollTo.scrollToPreviousPage(scrollView, cycle: cycle, animated: animated,
        currentPageIndex: currentPageIndex, numberOfPages: numberOfPages)
    }
  }
  
  func removeAll() {
    if let scrollView = scrollView {
      let pages = AukScrollViewContent.aukPages(scrollView)
      
      for page in pages {
        page.removeFromSuperview()
      }
    }
    
    pageIndicatorContainer?.updateNumberOfPages(numberOfPages)
    pageIndicatorContainer?.updateCurrentPage(currentPageIndex)
  }
  
  var numberOfPages: Int {
    if let scrollView = scrollView {
      return AukScrollViewContent.aukPages(scrollView).count
    }
    
    return 0
  }
  
  var currentPageIndex: Int {
    if let scrollView = scrollView {
      let width = Double(scrollView.bounds.size.width)
      let offset = Double(scrollView.contentOffset.x)
      
      return Int(round(offset / width))
    }
    
    return 0
  }
  
  func startAutoScroll(#delaySeconds: Double) {
    autoscrollTimer = MoaTimer.runAfter(delaySeconds, repeats: true) { timer in
      
    }
  }
  
  func setup() {
    createPageIdicator()
    scrollView?.showsHorizontalScrollIndicator = settings.showsHorizontalScrollIndicator
    scrollView?.pagingEnabled = settings.pagingEnabled
  }
  
  /// Create a page, add it to the scroll view content and layout.
  private func createPage() -> AukPage {
    let page = AukPage()
    
    if let scrollView = scrollView {
      scrollView.addSubview(page)
      AukScrollViewContent.layout(scrollView)
    }
    
    pageIndicatorContainer?.updateNumberOfPages(numberOfPages)
    
    return page
  }
  
  func onScroll() {
    if let scrollView = scrollView {
      AukPageVisibility.tellPagesAboutTheirVisibility(scrollView, settings: settings)
      pageIndicatorContainer?.updateCurrentPage(currentPageIndex)
    }
  }
  
  private func createPageIdicator() {
    if pageIndicatorContainer != nil { return } // Already created a page indicator container 
    
    if let scrollView = scrollView,
      superview = scrollView.superview {
        
      let container = AukPageIndicatorContainer()
      superview.addSubview(container)
      pageIndicatorContainer = container
      container.setup(settings, scrollView: scrollView)
    }
  }
}