import UIKit
import moa

/**

Downloads and shows a single remote image.

*/
class AukRemoteImage {
  var url: String?
  weak var imageView: UIImageView?
  
  init() { }
  
  /// True when image has been successfully downloaded
  var didFinishDownload = false
  
  func setup(url: String, imageView: UIImageView, settings: AukSettings) {
      
    self.url = url
    self.imageView = imageView
    
    setPlaceholderImage(settings)
  }
  
  /// Sends image download HTTP request.
  func downloadImage(settings: AukSettings) {
    if imageView?.moa.url != nil { return } // Download has already started
    if didFinishDownload { return } // Image has already been downloaded
    
    imageView?.moa.onSuccessAsync = { [weak self] image in
      self?.didReceiveImageAsync(image, settings: settings)
      return image
    }
    
    imageView?.moa.onErrorAsync = { [weak self] _, _ in
      self?.onDownloadErrorAsync(settings)
    }
    
    imageView?.moa.url = url
  }
  
  private func onDownloadErrorAsync(settings: AukSettings) {
    if let errorImage = settings.errorImage {
      iiQ.main { [weak self] in
        imageView?.image = errorImage
      }
      
      didReceiveImageAsync(errorImage, settings: settings)
    }
  }
  
  /// Cancel current image download HTTP request.
  func cancelDownload() {
    // Cancel current download by setting url to nil
    imageView?.moa.url = nil
  }
  
  func didReceiveImageAsync(image: UIImage, settings: AukSettings) {
    didFinishDownload = true
    
    iiQ.main { [weak self] in
      if let imageView = self?.imageView {
        AukRemoteImage.animateImageView(imageView, settings: settings)
      }
    }
  }
  
  private func setPlaceholderImage(settings: AukSettings) {
    if let placeholderImage = settings.placeholderImage,
      imageView = imageView {
        
      imageView.image = placeholderImage
      AukRemoteImage.animateImageView(imageView, settings: settings)
    }
  }
  
  private static func animateImageView(imageView: UIImageView, settings: AukSettings) {
    imageView.alpha = 0
    let interval = NSTimeInterval(settings.remoteImageAnimationIntervalSeconds)
    
    UIView.animateWithDuration(interval, animations: {
      imageView.alpha = 1
    })
  }
}