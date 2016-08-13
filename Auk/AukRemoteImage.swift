import UIKit
import moa

/**

Downloads and shows a single remote image.

*/
class AukRemoteImage {
  var url: String?
  weak var imageView: UIImageView?
  weak var placeholderImageView: UIImageView?

  init() { }

  /// True when image has been successfully downloaded
  var didFinishDownload = false

  func setup(_ url: String, imageView: UIImageView, placeholderImageView: UIImageView?,
    settings: AukSettings) {

    self.url = url
    self.imageView = imageView
    self.placeholderImageView = placeholderImageView
    setPlaceholderImage(settings)
  }

  /// Sends image download HTTP request.
  func downloadImage(_ settings: AukSettings) {
    if imageView?.moa.url != nil { return } // Download has already started
    if didFinishDownload { return } // Image has already been downloaded

    imageView?.moa.errorImage = settings.errorImage

    imageView?.moa.onSuccessAsync = { [weak self] image in
      self?.didReceiveImageAsync(image, settings: settings)
      return image
    }

    imageView?.moa.url = url
  }

  /// Cancel current image download HTTP request.
  func cancelDownload() {
    // Cancel current download by setting url to nil
    imageView?.moa.url = nil
  }

  func didReceiveImageAsync(_ image: UIImage, settings: AukSettings) {
    didFinishDownload = true

    iiQ.main { [weak self] in
      guard let imageView = self?.imageView else { return }
      AukRemoteImage.animateImageView(imageView, show: true, settings: settings)
    
      if let placeholderImageView = self?.placeholderImageView {
        AukRemoteImage.animateImageView(placeholderImageView, show: false, settings: settings)
      }
    }
  }

  private static func animateImageView(_ imageView: UIImageView, show: Bool, settings: AukSettings) {
    imageView.alpha = show ? 0: 1
    let interval = TimeInterval(settings.remoteImageAnimationIntervalSeconds)
    
    UIView.animate(withDuration: interval, animations: {
      imageView.alpha = show ? 1: 0
    })
  }
  
  private func setPlaceholderImage(_ settings: AukSettings) {
    if let placeholderImage = settings.placeholderImage,
      let placeholderImageView = placeholderImageView {
        
      placeholderImageView.image = placeholderImage
    }
  }
}
