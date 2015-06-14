import UIKit

/**

Shows images in the scroll view with paging indicator.

Call its `show` method to show an image in the scroll view.

*/
public protocol AukInterface: class {
  /// Adds an image to the scroll view.
  func show(#image: UIImage)
  
  /// Downloads a remote image and adds it to the scroll view.
  func show(#url: String)
}