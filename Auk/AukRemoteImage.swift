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
    imageView.image = settings.placeholderImage
  }
  
  /// Sends image download HTTP request.
  func downloadImage() {
    if imageView?.moa.url != nil { return } // Download has already started
    if didFinishDownload { return } // Image has already been downloaded
    
    imageView?.moa.onSuccessAsync = { [weak self] image in
      self?.didReceiveImageAsync(image)
      return image
    }
    
    imageView?.moa.url = url
  }
  
  /// Cancel current image download HTTP request.
  func cancelDownload() {
    // Cancel current download by setting url to nil
    imageView?.moa.url = nil
  }
  
  func didReceiveImageAsync(image: UIImage) {
    didFinishDownload = true
  }
}