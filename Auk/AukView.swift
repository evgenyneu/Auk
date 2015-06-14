import UIKit

/// The view is added to the scroll view and contains image view.
class TheAukView: UIView {
  
  var imageView: UIImageView?
  
  private func setup() {
    if imageView != nil { return }
    
    let newImageView = UIImageView()
    addSubview(newImageView)
    imageView = newImageView
  }
  
  func show(#image: UIImage) {
    setup()
    imageView?.image = image
  }
}