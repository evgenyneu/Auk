import UIKit

/// The view for an individual page of the scroll view containing an image.
final class AukPage: UIView {
  
  // Contain a local image.
  weak var imageView: UIImageView?
  
  // Contains a URL for the remote image, if any.
  var remoteImage: AukRemoteImage?
  
  /**
  
  Shows an image.
  
  :param: image: The image to be shown
  :param: settings: Auk settings.
  
  */
  func show(#image: UIImage, settings: AukSettings) {
    createAndLayoutImageView(settings)
    
    imageView?.image = image
  }
  
  /**
  
  Shows a remote image. The image download stars if/when the page becomes visible to the user.
  
  :param: url: The URL to the image to be displayed.
  :param: settings: Auk settings.
  
  */
  func show(#url: String, settings: AukSettings) {
    createAndLayoutImageView(settings)
    
    if let imageView = imageView {
      remoteImage = AukRemoteImage()
      remoteImage?.setup(url, imageView: imageView, settings: settings)
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
  
  :param: settings: Auk settings.
  
  */
  func createAndLayoutImageView(settings: AukSettings) {
    if imageView != nil { return }
    
    let newImageView = UIImageView()
    newImageView.contentMode = settings.contentMode
    addSubview(newImageView)
    imageView = newImageView
    
    layoutImageView(newImageView)
  }
  
  /**
  
  Creates Auto Layout constrains for the image view.
  
  :param: imageView: Image view that is used to create Auto Layout constraints.
  
  */
  private func layoutImageView(imageView: UIImageView) {
    imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    iiAutolayoutConstraints.fillParent(imageView, parentView: self, margin: 0, vertically: false)
    iiAutolayoutConstraints.fillParent(imageView, parentView: self, margin: 0, vertically: true)
  }
}