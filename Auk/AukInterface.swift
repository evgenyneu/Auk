import UIKit

/**

Shows images in the scroll view with page indicator.

Call its `show` method to display an image in the scroll view.

*/
public protocol AukInterface: class {
  /**

  Shows the image in the scroll view.

  :param: image Image to be shown in the scroll view.
  
  */
  func show(#image: UIImage)
  
  /// Downloads a remote image and adds it to the scroll view.
  func show(#url: String)  
  
  /**
  
  Change current page. This function is used for animating the scroll view content during orientation change. It is called in viewWillTransitionToSize and inside animateAlongsideTransition animation block.
  
      override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
      
        let pageIndex = scrollView.auk.pageIndex
        
        coordinator.animateAlongsideTransition({ [weak self] _ in
          self?.scrollView.auk.changePage(pageIndex, pageWidth: size.width)
        }, completion: nil)
      }
  
  */
  func changePage(toPageIndex: Int, pageWidth: CGFloat)
  
  /// Returns the current page index.
  var pageIndex: Int { get }
}