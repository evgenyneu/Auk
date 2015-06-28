import UIKit
import moa

/**

Downloads and shows a single remote image.

*/
class AukRemoteImage {
  let url: String
  let imageView: UIImageView
  
  /// True when image has been successfully downloaded
  var didFinishDownload = false
  
  init(url: String, imageView: UIImageView) {
    self.url = url
    self.imageView = imageView
  }
  
  /// Sends image download HTTP request.
  func downloadImage() {
    if imageView.moa.url != nil { return } // Download has already started
    if didFinishDownload { return } // Image has already been downloaded
    
    imageView.moa.onSuccessAsync = { [weak self] image in
      self?.didReceiveImageAsync(image)
      return image
    }
    
    println("Downloading image \(url)")
    imageView.moa.url = url
  }
  
  /// Cancel current image download HTTP request.
  func cancelDownload() {
    if imageView.moa.url != nil {
      println("cancelDownload")
    }
    // Cancel current download by setting url to nil
    imageView.moa.url = nil
  }
  
  func didReceiveImageAsync(image: UIImage) {
    didFinishDownload = true
  }
}