import UIKit

/**

Shows images in the scroll view with page indicator.
Auk extends UIScrollView class by creating the auk property that you can use for showing images.

Usage:

    // Show remote image
    scrollView.auk.show(url: "http://site.com/bird.jpg")

    // Show local image
    scrollView.auk.show(image: UIImage(named: "bird"))

*/
public class Auk {
  
  // ---------------------------------
  //
  // MARK: - Public interface
  //
  // ---------------------------------
  
  /**
  
  Settings that control appearance of the images and page indicator.
  
  */
  public var settings = AukSettings()
  
  /**
  
  Shows a local image in the scroll view.
  
  :param: image: Image to be shown in the scroll view.
  
  */
  public func show(#image: UIImage) {
    setup()
    let page = createPage()
    page.show(image: image, settings: settings)
  }
  
  /**
  
  Downloads a remote image and adds it to the scroll view. Use `Moa.settings.cache` property to configure image caching.
  
  :param: url: Url of the image to be shown.
  
  */
  public func show(#url: String) {
    setup()
    let page = createPage()
    page.show(url: url, settings: settings)
    
    if let scrollView = scrollView {
      AukPageVisibility.tellPagesAboutTheirVisibility(scrollView, settings: settings)
    }
  }
  
  /**
  
  Changes the current page.
  
  :param: pageIndex: Index of the page to show.
  :param: animated: The page change will be animated when `true`.
  
  */
  public func scrollTo(pageIndex: Int, animated: Bool) {
    if let scrollView = scrollView {
      AukScrollTo.scrollTo(scrollView, pageIndex: pageIndex, animated: animated,
        numberOfPages: numberOfPages)
    }
  }
  
  /**
  
  Changes both the current page and the page width.
  
  This function can be used for animating the scroll view content during orientation change. It is called in viewWillTransitionToSize and inside animateAlongsideTransition animation block.
  
      override func viewWillTransitionToSize(size: CGSize,
      withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
          let pageIndex = scrollView.auk.pageIndex
          
          coordinator.animateAlongsideTransition({ [weak self] _ in
          self?.scrollView.auk.changePage(pageIndex, pageWidth: size.width, animated: false)
        }, completion: nil)
      }
  
  More information: https://github.com/evgenyneu/Auk/wiki/Animate-size-change
  
  :param: toPageIndex: Index of the page that will be made a current page.
  :param: pageWidth: The new page width.
  :param: animated: The page change will be animated when `true`.
  
  */
  public func scrollTo(pageIndex: Int, pageWidth: CGFloat, animated: Bool) {
    if let scrollView = scrollView {
      AukScrollTo.scrollTo(scrollView, pageIndex: pageIndex, pageWidth: pageWidth,
        animated: animated, numberOfPages: numberOfPages)
    }
  }
  
  /**
  
  Scrolls to the next page.
  
  */
  public func scrollToNextPage() {
    scrollToNextPage(cycle: true, animated: true)
  }
  
  /**
  
  Scrolls to the next page.
  
  :param: cycle: If `true` it scrolls to the first page from the last one. If `false` the scrolling stops at the last page.
  :param: animated: The page change will be animated when `true`.
  
  */
  public func scrollToNextPage(#cycle: Bool, animated: Bool) {
    if let scrollView = scrollView {
      AukScrollTo.scrollToNextPage(scrollView, cycle: cycle, animated: animated,
        currentPageIndex: currentPageIndex, numberOfPages: numberOfPages)
    }
  }
  
  /**
  
  Scrolls to the previous page.
  
  */
  public func scrollToPreviousPage() {
    scrollToPreviousPage(cycle: true, animated: true)
  }
  
  /**
  
  Scrolls to the previous page.
  
  :param: cycle: If true it scrolls to the last page from the first one. If false the scrolling stops at the first page.
  :param: animated: The page change will be animated when `true`.
  
  */
  public func scrollToPreviousPage(#cycle: Bool, animated: Bool) {
    if let scrollView = scrollView {
      AukScrollTo.scrollToPreviousPage(scrollView, cycle: cycle, animated: animated,
        currentPageIndex: currentPageIndex, numberOfPages: numberOfPages)
    }
  }
  
  /**
  
  Removes all images from the scroll view.
  
  */
  public func removeAll() {
    if let scrollView = scrollView {
      let pages = AukScrollViewContent.aukPages(scrollView)
      
      for page in pages {
        page.removeFromSuperview()
      }
    }
    
    pageIndicatorContainer?.updateNumberOfPages(numberOfPages)
    pageIndicatorContainer?.updateCurrentPage(currentPageIndex)
  }
  
  /// Returns the current number of pages.
  public var numberOfPages: Int {
    if let scrollView = scrollView {
      return AukScrollViewContent.aukPages(scrollView).count
    }
    
    return 0
  }
  
  /**
  
  Returns the current page index. If pages are being scrolled and there are two of them on screen the page index will indicate the page that occupies bigger portion of the screen at the moment.
  
  */
  public var currentPageIndex: Int {
    if let scrollView = scrollView {
      let width = Double(scrollView.bounds.size.width)
      let offset = Double(scrollView.contentOffset.x)
      
      return Int(round(offset / width))
    }
    
    return 0
  }
  
  /**
  
  Starts auto scrolling of the pages with the given delay in seconds.
  
  :param: delaySeconds: Amount of time in second each page is visible before scrolling to the next.
  
  */
  public func startAutoScroll(#delaySeconds: Double) {
    startAutoScroll(delaySeconds: delaySeconds, forward: true,
      cycle: true, animated: true)
  }
  
  /**
  
  Starts auto scrolling of the pages with the given delay in seconds.
  
  :param: delaySeconds: Amount of time in second each page is visible before scrolling to the next.
  :param: forward: When true the scrolling is done from left to right direction.
  :param: cycle: If true it scrolls to the first page from the last one. If false the scrolling stops at the last page.
  :param: animated: The page change will be animated when `true`.
  
  */
  public func startAutoScroll(#delaySeconds: Double, forward: Bool,
    cycle: Bool, animated: Bool) {
      
    if let scrollView = scrollView {
      autoscroll.startAutoScroll(scrollView, delaySeconds: delaySeconds,
        forward: forward, cycle: cycle, animated: animated, auk: self)
    }
  }
  
  /**
  
  Stops auto scrolling of the pages.
  
  */
  public func stopAutoScroll() {
    autoscroll.stopAutoScroll()
  }
  
  // ---------------------------------
  //
  // MARK: - Internal functionality
  //
  // ---------------------------------
  
  var scrollViewDelegate = AukScrollViewDelegate()
  var pageIndicatorContainer: AukPageIndicatorContainer?
  var autoscroll = AukAutoscroll()
  private weak var scrollView: UIScrollView?
  
  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
    
    scrollViewDelegate.onScroll = { [weak self] in
      self?.onScroll()
    }
    
    scrollViewDelegate.onScrollByUser = { [weak self] in
      self?.stopAutoScroll()
    }
    
    scrollViewDelegate.delegate = scrollView.delegate
    scrollView.delegate = scrollViewDelegate
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
    if !settings.pageControl.visible { return }
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