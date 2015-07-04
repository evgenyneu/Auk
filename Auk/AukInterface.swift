import UIKit

/**

Shows images in the scroll view with page indicator.

Call its `show` method to display an image in the scroll view.

*/
public protocol AukInterface: class {
  
  /**
  
  Settings that control appearance of the images and the page indicator.
  
  */
  var settings: AukSettings { get set }
  
  /**

  Shows the image in the scroll view.

  :param: image: Image to be shown in the scroll view.
  
  */
  func show(#image: UIImage)
  
  /**

  Downloads a remote image and adds it to the scroll view.

  :param: url: Url of the image to be shown.
  
  */
  func show(#url: String)
  
  /**
  
  Change current page.
  
  :param: pageIndex: Index of the page that will be made a current page.
  :param: animated: Use animation.
  
  */
  func scrollTo(pageIndex: Int, animated: Bool)
  
  
  /**
  
  Scrolls to the next page.
  
  */
  func scrollToNextPage()
  
  /**

  Scrolls to the next page.
  
  :param: cycle: If true it scrolls to the first page from the last one. If false the scrolling stops at the last page.
  :param: animated: Use animation.
  
  */
  func scrollToNextPage(#cycle: Bool, animated: Bool)
  
  /**
  
  Scrolls to the previous page.
  
  */
  func scrollToPreviousPage()
  
  /**
  
  Scrolls to the previous page.
  
  :param: cycle: If true it scrolls to the last page from the first one. If false the scrolling stops at the first page.
  :param: animated: Use animation.
  
  */
  func scrollToPreviousPage(#cycle: Bool, animated: Bool)
  
  /**
  
  Removes all images from the scroll view.
  
  */
  func removeAll()
  
  /**
  
  Start auto scrolling the pages with the given delay in seconds.
  
  :param: delaySeconds: Amount of time in second each page is visible before scrolling to the next.
  
  */
  func startAutoScroll(#delaySeconds: Double)
  
  /**
  
  Stop auto scrolling the pages.
    
  */
  func stopAutoScroll()
  
  /**
  
  Start auto scrolling the pages with the given delay in seconds.
  
  :param: delaySeconds: Amount of time in second each page is visible before scrolling to the next.
  :param: forward: When true the scrolling is done from left to right direction.
  :param: cycle: If true it scrolls to the first page from the last one. If false the scrolling stops at the last page.
  :param: animated: If true the scrolling is done with animation.
  
  */
  func startAutoScroll(#delaySeconds: Double, forward: Bool, cycle: Bool, animated: Bool)
  
  /**
  
  Change current page and the page width.
  
  This function can be used for animating the scroll view content during orientation change. It is called in viewWillTransitionToSize and inside animateAlongsideTransition animation block.
  
  override func viewWillTransitionToSize(size: CGSize,
  withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
  
  super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
  
  let pageIndex = scrollView.auk.pageIndex
  
  coordinator.animateAlongsideTransition({ [weak self] _ in
  self?.scrollView.auk.changePage(pageIndex, pageWidth: size.width, animated: false)
  }, completion: nil)
  }
  
  :param: toPageIndex: Index of the page that will be made a current page.
  :param: pageWidth: The new page width.
  :param: animated: Use animation.
  
  */
  func scrollTo(pageIndex: Int, pageWidth: CGFloat, animated: Bool)
  
  /**

  Returns the current page index. If pages are being scrolled and there are two of them on screen the page index will indicate the page that occupies bigger portion of the screen at the moment.

  */
  var currentPageIndex: Int { get }
  
  /// Return the current number of pages.
  var numberOfPages: Int { get }
}