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

  Updates the size and position the content views inside the scroll view. It is called then the size of the scroll view changes (on orientation change, for example).

  :param: size: The size of the scroll view.
  
  */
  func relayout(size: CGSize)
  
  /**
  
  Hides all the pages except the current one. This function is used for animating the scroll view content during orientation change. It is called before the size change starts.
  
  */
  func hideAllPagesExceptCurrent()
  
  /**
  
  Shows all the pages. This function is used for animating the scroll view content during orientation change. It is called after the size change finishes.
  
  */
  func showPages()
}