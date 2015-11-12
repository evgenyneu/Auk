import UIKit

/**

Shows images in the scroll view with page indicator.
Auk extends UIScrollView class by creating the auk property that you can use for showing images.

Usage:

    // Show remote image
    scrollView.auk.show(url: "http://site.com/bird.jpg")

    // Show local image
    if let image = UIImage(named: "bird.jpg") {
      scrollView.auk.show(image: image)
    }

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

  - parameter image: Image to be shown in the scroll view.
  - parameter accessibilityLabel: Text describing the image that will be spoken in accessibility mode. For example: "Picture of a pony standing in a flower pot.".

  */
  public func show(image image: UIImage, accessibilityLabel: String? = nil) {
    setup()
    let page = createPage(accessibilityLabel)
    page.show(image: image, settings: settings)
  }

  /**

  Downloads a remote image and adds it to the scroll view. Use `Moa.settings.cache` property to configure image caching.

  - parameter url: Url of the image to be shown.
  - parameter accessibilityLabel: Text describing the image that will be spoken in accessibility mode. For example: "Picture of a pony standing in a flower pot.".

  */
  public func show(url url: String, accessibilityLabel: String? = nil) {
    setup()
    let page = createPage(accessibilityLabel)
    page.show(url: url, settings: settings)

    if let scrollView = scrollView {
      AukPageVisibility.tellPagesAboutTheirVisibility(scrollView, settings: settings)
    }
  }

  /**

  Changes the current page.

  - parameter pageIndex: Index of the page to show.
  - parameter animated: The page change will be animated when `true`.

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

  More information: https://github.com/evgenyneu/Auk/wiki/Size-animation

  - parameter toPageIndex: Index of the page that will be made a current page.
  - parameter pageWidth: The new page width.
  - parameter animated: The page change will be animated when `true`.

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

  - parameter cycle: If `true` it scrolls to the first page from the last one. If `false` the scrolling stops at the last page.
  - parameter animated: The page change will be animated when `true`.

  */
  public func scrollToNextPage(cycle cycle: Bool, animated: Bool) {
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

  - parameter cycle: If true it scrolls to the last page from the first one. If false the scrolling stops at the first page.
  - parameter animated: The page change will be animated when `true`.

  */
  public func scrollToPreviousPage(cycle cycle: Bool, animated: Bool) {
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
  
  /// Returns array of currently visible images. Placeholder images are not returned here.
  public var images: [UIImage] {
    guard let scrollView = scrollView else { return [] }
    
    var images = [UIImage]()
    
    for page in AukScrollViewContent.aukPages(scrollView) {
      if let image = page.imageView?.image {
        images.append(image)
      }
    }
    
    return images
  }

  /**

  Returns the current page index. If pages are being scrolled and there are two of them on screen the page index will indicate the page that occupies bigger portion of the screen at the moment.

  */
  public var currentPageIndex: Int {
    if let scrollView = scrollView {
      let width = Double(scrollView.bounds.size.width)
      let offset = Double(scrollView.contentOffset.x)
      
      var value = Int(round(offset / width))
      
      // Page # 0 is the rightmost in the right-to-left language layout
      if RightToLeft.isRightToLeft(scrollView) {
        value = numberOfPages - value - 1
        if value < 0 { value = 0 }
      }
      
      return value
    }

    return 0
  }

  /**

  Starts auto scrolling of the pages with the given delay in seconds.

  - parameter delaySeconds: Amount of time in second each page is visible before scrolling to the next.

  */
  public func startAutoScroll(delaySeconds delaySeconds: Double) {
    startAutoScroll(delaySeconds: delaySeconds, forward: true,
      cycle: true, animated: true)
  }

  /**

  Starts auto scrolling of the pages with the given delay in seconds.

  - parameter delaySeconds: Amount of time in second each page is visible before scrolling to the next.
  - parameter forward: When true the scrolling is done from left to right direction.
  - parameter cycle: If true it scrolls to the first page from the last one. If false the scrolling stops at the last page.
  - parameter animated: The page change will be animated when `true`.

  */
  public func startAutoScroll(delaySeconds delaySeconds: Double, forward: Bool,
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
  private func createPage(accessibilityLabel: String? = nil) -> AukPage {
    let page = AukPage()
    page.clipsToBounds = true
    page.makeAccessible(accessibilityLabel)

    if let scrollView = scrollView {
      // Pages are added to the left of the current page
      // in the right-to-left language layout.
      // So we need to increase content offset to keep the current page visible.
      if RightToLeft.isRightToLeft(scrollView) && numberOfPages > 0 {
        scrollView.contentOffset.x += scrollView.bounds.size.width
      }
      
      scrollView.addSubview(page)

      AukScrollViewContent.layout(scrollView)
    }

    pageIndicatorContainer?.updateNumberOfPages(numberOfPages)
    pageIndicatorContainer?.updateCurrentPage(currentPageIndex)
    

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
      container.didTapPageControlCallback = didTapPageControl
      superview.insertSubview(container, aboveSubview: scrollView)
      pageIndicatorContainer = container
      container.setup(settings, scrollView: scrollView)
    }
  }
  
  private func didTapPageControl(pageIndex: Int) {
    scrollTo(pageIndex, animated: true)
  }
}