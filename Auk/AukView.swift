import UIKit

/// The view is added to the scroll view and contains image view.
class AukView: UIView {
  
  var imageView: UIImageView?
  
  func show(#image: UIImage) {
    setup()
    imageView?.image = image
  }
  
  private func setup() {
    if imageView != nil { return }
    
    let newImageView = UIImageView()
    addSubview(newImageView)
    imageView = newImageView
    
    layoutImageView(newImageView)
  }
  
  private func layoutImageView(imageView: UIImageView) {
    imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    iiAutolayoutConstraints.fillParent(imageView, parentView: self, margin: 0, vertically: false)
    iiAutolayoutConstraints.fillParent(imageView, parentView: self, margin: 0, vertically: true)
  }
}