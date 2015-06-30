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

  - parameter image: Image to be shown in the scroll view.
  
  */
  func show(image image: UIImage)
  
  /**

  Downloads a remote image and adds it to the scroll view.

  - parameter url: Url of the image to be shown.
  
  */
  func show(url url: String)
  
  /**
  
  Removes all images from the scroll view.
  
  */
  func removeAll()
  
  /**
  
  Change current page.
  
  - parameter toPageIndex:: Index of the page that will be made a current page.
  - parameter animated: Use animation.
  
  */
  func changePage(toPageIndex: Int, animated: Bool)
  
  /**
  
  Change current page.
  
  This function can be used for animating the scroll view content during orientation change. It is called in viewWillTransitionToSize and inside animateAlongsideTransition animation block.
  
      override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
      
        let pageIndex = scrollView.auk.pageIndex
        
        coordinator.animateAlongsideTransition({ [weak self] _ in
          self?.scrollView.auk.changePage(pageIndex, pageWidth: size.width, animated: false)
        }, completion: nil)
      }
  
  - parameter toPageIndex:: Index of the page that will be made a current page.
  - parameter pageWidth:: The new page width.
  - parameter animated: Use animation.
  
  */
  func changePage(toPageIndex: Int, pageWidth: CGFloat, animated: Bool)
  
  /**

  Returns the current page index. If pages are being scrolled and there are two of them on screen the page index will indicate the page that occupies bigger portion of the screen at the moment.

  */
  var currentPageIndex: Int { get }
  
  /// Return the current number of pages.
  var numberOfPages: Int { get }
}