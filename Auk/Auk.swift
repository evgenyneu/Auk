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
  public func show(image: UIImage, accessibilityLabel: String? = nil) {
    setup()
    let page = createPage(accessibilityLabel)
    page.show(image: image, settings: settings)
  }

  /**

  Downloads a remote image and adds it to the scroll view. Use `Moa.settings.cache` property to configure image caching.

  - parameter url: Url of the image to be shown.
   
  - parameter accessibilityLabel: Text describing the image that will be spoken in accessibility mode. For example: "Picture of a pony standing in a flower pot.".

  */
  public func show(url: String, accessibilityLabel: String? = nil) {
    setup()
    let page = createPage(accessibilityLabel)
    page.show(url: url, settings: settings)
    tellPagesAboutTheirVisibility()
  }
  
  /**
   
   Replaces an image on a given page.
   
   - parameter atIndex: the index of the image to change. Does nothing if the index is less than zero or greater than the largest index.
   
   - parameter image: Image to be shown in the scroll view.
   
   - parameter accessibilityLabel: Text describing the image that will be spoken in accessibility mode.
   For example: "Picture of a pony standing in a flower pot.".
   
   */
  public func updatePage(atIndex index: Int, image: UIImage, accessibilityLabel: String? = nil) {
    guard let scrollView = scrollView,
      let page = AukScrollViewContent.page(atIndex: index, scrollView: scrollView) else { return }
      
    page.prepareForReuse()
    page.accessibilityLabel = accessibilityLabel
    page.show(image: image, settings: settings)
  }
  
  /**
   
   Downloads an image and uses it to replace an image on a given page. The current image is replaced when the new image has finished downloading. Use `Moa.settings.cache` property to configure image caching.
   
   - parameter atIndex: the index of the image to change. Does nothing if the index is less than zero or greater than the largest index.
   
   - parameter url: Url of the image to be shown.
   
   - parameter accessibilityLabel: Text describing the image that will be spoken in accessibility mode.
   For example: "Picture of a pony standing in a flower pot.".
   
   */
  public func updatePage(atIndex index: Int, url: String, accessibilityLabel: String? = nil) {
    guard let scrollView = scrollView,
      let page = AukScrollViewContent.page(atIndex: index, scrollView: scrollView) else { return }
      
    var updateSettings = settings
    
    // Use current image as a placeholder in order to avoid abrupt change
    // while the new one is being downloaded
    if let currentImage = page.imageView?.image {
        updateSettings.placeholderImage = currentImage
    }
    
    page.prepareForReuse()
    page.accessibilityLabel = accessibilityLabel
    page.show(url: url, settings: updateSettings)
    tellPagesAboutTheirVisibility()
  }

  /**

  Changes the current page.

  - parameter atIndex: Index of the page to show.
   
  - parameter animated: The page change will be animated when `true`.

  */
  public func scrollToPage(atIndex index: Int, animated: Bool) {
    guard let scrollView = scrollView else { return }
    
    AukScrollTo.scrollToPage(scrollView, atIndex: index, animated: animated,
                             numberOfPages: numberOfPages)
  }

  /**

  Changes both the current page and the page width.

  This function can be used for animating the scroll view content during orientation change. It is called in viewWillTransitionToSize and inside animateAlongsideTransition animation block.

      override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
         
         super.viewWillTransition(to: size, with: coordinator)
   
         guard let pageIndex = scrollView.auk.currentPageIndex else { return }
         let newScrollViewWidth = size.width // Assuming scroll view occupies 100% of the screen width
         
         coordinator.animate(alongsideTransition: { [weak self] _ in
           self?.scrollView.auk.scrollToPage(atIndex: pageIndex, pageWidth: newScrollViewWidth, animated: false)
         }, completion: nil)
      }

  More information: https://github.com/evgenyneu/Auk/wiki/Size-animation

  - parameter atIndex: Index of the page that will be made a current page.
   
  - parameter pageWidth: The new page width.
   
  - parameter animated: The page change will be animated when `true`.

  */
  public func scrollToPage(atIndex index: Int, pageWidth: CGFloat, animated: Bool) {
    guard let scrollView = scrollView else { return }
    
    AukScrollTo.scrollToPage(scrollView, atIndex: index, pageWidth: pageWidth,
      animated: animated, numberOfPages: numberOfPages)
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
  public func scrollToNextPage(cycle: Bool, animated: Bool) {
    guard let scrollView = scrollView, let currentPageIndex = currentPageIndex else { return }
    
    AukScrollTo.scrollToNextPage(scrollView, cycle: cycle, animated: animated,
      currentPageIndex: currentPageIndex, numberOfPages: numberOfPages)
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
  public func scrollToPreviousPage(cycle: Bool, animated: Bool) {
    if let scrollView = scrollView, let currentPageIndex = currentPageIndex {
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
      
      pages.forEach {
        $0.removeFromSuperview()
      }
    }

    updatePageIndicator()
  }
  
  /**
 
  Removes page at current presented index from the scroll view.
  Does nothing if there no current page.
  
  - parameter animated: Boolean indicating if the layout update after the removal of the page should be animated, defaults to false.
  
  - parameter completion: Closure executed when page has been removed and layout updated.
  
  */
  public func removeCurrentPage(animated: Bool = false, completion: (() -> Void)? = nil) {
    
    if let currentPageIndex = currentPageIndex {
      removePage(atIndex: currentPageIndex, animated: animated, completion: completion)
    }
  }
  
  /**
   
  Removes page at the provided index from the scroll view.
  Does nothing if the index does not represent an existing page.
  
  - parameter index: The index of the page your want to remove from the scroll view.
  
  - parameter animated: Optional Boolean indicating if the layout update after the removal of the page should be animated, defaults to false.
  
  - parameter completion: Closure executed when page has been removed and layout updated.
  
  */
  public func removePage(atIndex index: Int, animated: Bool = false, completion: (() -> Void)? = nil) {
    
    guard let scrollView = scrollView,
      let page = AukScrollViewContent.page(atIndex: index, scrollView: scrollView) else { return }
    
    iiAnimator.fadeOut(view: page, animated: animated,
      withDuration: settings.removePageFadeOutAnimationDurationSeconds,
      completion: { [weak self] in
        // Finish fading out. Now remove the page from the scroll view.
        self?.removePage(page: page, animated: animated, completion: completion)
      }
    )
  }

  /// Returns the current number of pages.
  public var numberOfPages: Int {
    guard let scrollView = scrollView else { return 0 }
    return AukScrollViewContent.aukPages(scrollView).count
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

  Returns the current page index. If pages are being scrolled and there are two of them on screen the page index will indicate the page that occupies bigger portion of the screen at the moment. Returns nil if there are no pages. If scrolled way to the left or right beyond the pages it will return zero or the last index respectively.

  */
  public var currentPageIndex: Int? {
    guard let scrollView = scrollView else { return nil }
    if numberOfPages == 0 { return nil }
    
    let width = Double(scrollView.bounds.size.width)
    let offset = Double(scrollView.contentOffset.x)
    
    if width == 0 {
      print("Auk WARNING: scroll view has zero width.")
      return nil
    }
    
    var value = Int(round(offset / width))
    
    // Page # 0 is the rightmost in the right-to-left language layout
    if RightToLeft.isRightToLeft(scrollView) {
      value = numberOfPages - value - 1
    }
    
    if value < 0 { value = 0 }
    if value > numberOfPages - 1 { value = numberOfPages - 1 }
    
    return value
  }

  /**

  Starts auto scrolling of the pages with the given delay in seconds. Auto scrolling stops when the user starts scrolling manually.

  - parameter delaySeconds: Amount of time in second each page is visible before scrolling to the next.

  */
  public func startAutoScroll(delaySeconds: Double) {
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
  public func startAutoScroll(delaySeconds: Double, forward: Bool,
    cycle: Bool, animated: Bool) {

    guard let scrollView = scrollView else { return }
    
    autoscroll.startAutoScroll(scrollView, delaySeconds: delaySeconds,
      forward: forward, cycle: cycle, animated: animated, auk: self)
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

    // We stop auto scrolling when the user starts scrolling manually
    scrollViewDelegate.onScrollByUser = { [weak self] in
      self?.stopAutoScroll()
    }

    scrollViewDelegate.delegate = scrollView.delegate
    scrollView.delegate = scrollViewDelegate
  }

  func setup() {
    createPageIndicator()
    scrollView?.showsHorizontalScrollIndicator = settings.showsHorizontalScrollIndicator
    scrollView?.isPagingEnabled = settings.pagingEnabled
  }
    
  /// Create a page, add it to the scroll view content and layout.
  private func createPage(_ accessibilityLabel: String? = nil) -> AukPage {
    let page = AukPage()
    page.clipsToBounds = true
    page.makeAccessible(accessibilityLabel)

    guard let scrollView = scrollView else { return page }
    
    // Pages are added to the left of the current page
    // in the right-to-left language layout.
    // So we need to increase content offset to keep the current page visible.
    if RightToLeft.isRightToLeft(scrollView) && numberOfPages > 0 {
      scrollView.contentOffset.x += scrollView.bounds.size.width
    }
    
    scrollView.addSubview(page)

    AukScrollViewContent.layout(scrollView)

    updatePageIndicator()

    return page
  }

  func onScroll() {
    guard let currentPageIndex = currentPageIndex else { return }
    tellPagesAboutTheirVisibility()
    pageIndicatorContainer?.updateCurrentPage(currentPageIndex)
  }

  func createPageIndicator() {
    if !settings.pageControl.visible { return }
    if pageIndicatorContainer != nil { return } // Already created a page indicator container

    guard let scrollView = scrollView, let superview = scrollView.superview else { return }

    let container = AukPageIndicatorContainer()
    container.didTapPageControlCallback = didTapPageControl
    superview.insertSubview(container, aboveSubview: scrollView)
    pageIndicatorContainer = container
    container.setup(settings, scrollView: scrollView)
  }
  
  /// Show the number of pages and indicate the current page on the page indicator.
  func updatePageIndicator() {
    pageIndicatorContainer?.updateNumberOfPages(numberOfPages)
    guard let currentPageIndex = currentPageIndex else { return }
    pageIndicatorContainer?.updateCurrentPage(currentPageIndex)
  }
  
  private func didTapPageControl(atIndex index: Int) {
    scrollToPage(atIndex: index, animated: true)
  }
  
  /// Removes the page form the scroll view.
  func removePage(page: AukPage, animated: Bool, completion: (() -> Void)? = nil) {
    guard let scrollView = scrollView else { return }
    
    page.remoteImage?.cancelDownload()
    page.removeFromSuperview()
    
    AukScrollViewContent.layout(scrollView, animated: animated,
      animationDurationInSeconds: settings.removePageLayoutAnimationDurationSeconds,
      completion: { [weak self] in
        // Finished removing the page.
        
        //Update the page indicator.
        self?.updatePageIndicator()
        
        // Tell pages if they are visible.
        // This will start the download for the page that slided into the view in place of the removed page.
        self?.tellPagesAboutTheirVisibility()
        
        completion?()
      }
    )
  }
  
  /**
   
  Go through all the scroll view pages and tell them if they are visible or out of sight.
  The pages, in turn, if they are visible start the download of the image
  or cancel the download if they are out of sight.
   
  */
  func tellPagesAboutTheirVisibility() {
    guard let scrollView = scrollView, let currentPageIndex = currentPageIndex else { return }
      
    AukPageVisibility.tellPagesAboutTheirVisibility(scrollView, settings: settings,
                                                      currentPageIndex: currentPageIndex)
  }
}
