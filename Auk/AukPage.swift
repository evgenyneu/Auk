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
    
    if let imageView = imageView {
      remoteImage = AukRemoteImage(url: url, imageView: imageView)
    }
  }
  
  
  /**

  Called when the page is currently visible to user. It is called frequently each time 
  scroll view's content offset is changed.
  
  */
  func visibleNow() {
    remoteImage?.downloadImage()
  }
  
  /**
  
  Called when the page is currently not visible to user. It happes when the view is scrolled out in the scroll view and not visible on screen. This method called frequently each time scroll view's content offset is changed.
  
  */
  func outOfSightNow() {
    remoteImage?.cancelDownload()
  }

  
  func setup(settings: AukSettings) {
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