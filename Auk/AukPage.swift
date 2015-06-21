import UIKit

/// The view for an individual page of the scroll view containing an image.
final class AukPage: UIView {
  
  var imageView: UIImageView?
  var remoteImage: AukRemoteImage?
  
  func show(#image: UIImage, settings: AukSettings) {
    setup(settings)
    imageView?.image = image
  }
  
  func show(#url: String, settings: AukSettings) {
    setup(settings)
    remoteImage = AukRemoteImage(url: url)
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