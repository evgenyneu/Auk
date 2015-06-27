import UIKit

/// The view for an individual page of the scroll view containing an image.
final class AukPage: UIView {
  
  var imageView: UIImageView?
  var remoteImage: AukRemoteImage?
  
  func show(#image: UIImage, settings: AukSettings) {
    createAndLayoutImageView(settings)
    
    imageView?.image = image
  }
  
  func show(#url: String, settings: AukSettings) {
    createAndLayoutImageView(settings)
    
    if let imageView = imageView {
      remoteImage = AukRemoteImage(url: url, imageView: imageView)
    }
  }
  
  
  /**

  Called when the page is currently visible to user which triggers the image download. The function is called frequently each time scroll view's content offset is changed.
  
  */
  func visibleNow() {
    remoteImage?.downloadImage()
  }
  
  /**
  
  Called when the page is currently not visible to user which cancels the image download. The method called frequently each time scroll view's content offset is changed and the page is out of sight.
  
  */
  func outOfSightNow() {
    remoteImage?.cancelDownload()
  }
  
  /**
  
  Create and layout an image view.
  
  */
  func createAndLayoutImageView(settings: AukSettings) {
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