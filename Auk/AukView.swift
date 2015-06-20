import UIKit

/// The view is added to the scroll view and contains image view.
final class AukView: UIView {
  
  var imageView: UIImageView?
  
  func show(#image: UIImage, settings: AukSettings) {
    setup(settings)
    imageView?.image = image
  }
  
  private func setup(settings: AukSettings) {
    if imageView != nil { return }
    
    let newImageView = UIImageView()
    newImageView.contentMode = settings.contentMode
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