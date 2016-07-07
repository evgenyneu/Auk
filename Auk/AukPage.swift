import UIKit

/// The view for an individual page of the scroll view containing an image.
final class AukPage: UIView {
  
  // Image view for showing a placeholder image while remote image is being downloaded.
  // The view is only created when a placeholder image is specified in settings.
  weak var placeholderImageView: UIImageView?

  // Image view for showing local and remote images
  weak var imageView: UIImageView?
  
  // Contains a URL for the remote image, if any.
  var remoteImage: AukRemoteImage?
  
  /**
  
  Shows an image.
  
  - parameter image: The image to be shown
  - parameter settings: Auk settings.
  
  */
  func show(image: UIImage, settings: AukSettings) {
    imageView = createAndLayoutImageView(settings)
    imageView?.image = image
  }
  
  /**
  
  Shows a remote image. The image download stars if/when the page becomes visible to the user.
  
  - parameter url: The URL to the image to be displayed.
  - parameter settings: Auk settings.
  
  */
  func show(url: String, settings: AukSettings) {
    if settings.placeholderImage != nil {
      placeholderImageView = createAndLayoutImageView(settings)
    }
        
    imageView = createAndLayoutImageView(settings)
    
    if let imageView = imageView {
      remoteImage = AukRemoteImage()
      remoteImage?.setup(url, imageView: imageView, placeholderImageView: placeholderImageView,
        settings: settings)
    }
  }
  
  /**

  Called when the page is currently visible to user which triggers the image download. The function is called frequently each time scroll view's content offset is changed.
  
  */
  func visibleNow(_ settings: AukSettings) {
    remoteImage?.downloadImage(settings)
  }
  
  /**
  
  Called when the page is currently not visible to user which cancels the image download. The method called frequently each time scroll view's content offset is changed and the page is out of sight.
  
  */
  func outOfSightNow() {
    remoteImage?.cancelDownload()
  }
     
  /// Removes image views.
  func removeImageViews() {
    placeholderImageView?.removeFromSuperview()
    placeholderImageView = nil
    
    imageView?.removeFromSuperview()
    imageView = nil
  }
  
  /**
  
  Prepares the page view for reuse. Clears current content from the page and stops download.
   
  */
  func prepareForReuse() {
    removeImageViews()
    remoteImage?.cancelDownload()
    remoteImage = nil
  }
    
  /**
  
  Create and layout the remote image view.
  
  - parameter settings: Auk settings.
  
  */
  func createAndLayoutImageView(_ settings: AukSettings) -> UIImageView {
    let newImageView = AukPage.createImageView(settings)
    addSubview(newImageView)
    AukPage.layoutImageView(newImageView, superview: self)
    return newImageView
  }
  
  private static func createImageView(_ settings: AukSettings) -> UIImageView {
    let newImageView = UIImageView()
    newImageView.contentMode = settings.contentMode
    return newImageView
  }
  
  /**
  
  Creates Auto Layout constrains for the image view.
  
  - parameter imageView: Image view that is used to create Auto Layout constraints.
  
  */
  private static func layoutImageView(_ imageView: UIImageView, superview: UIView) {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    iiAutolayoutConstraints.fillParent(imageView, parentView: superview, margin: 0, vertically: false)
    iiAutolayoutConstraints.fillParent(imageView, parentView: superview, margin: 0, vertically: true)
  }
  
  func makeAccessible(_ accessibilityLabel: String?) {
    isAccessibilityElement = true
    accessibilityTraits = UIAccessibilityTraitImage
    self.accessibilityLabel = accessibilityLabel
  }
}
