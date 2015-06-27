import UIKit
import moa

/**

Downloads and shows a single remote image.

*/
struct AukRemoteImage {
  let url: String
  let imageView: UIImageView
  
  /// Sends image download HTTP request.
  func downloadImage() {
    if imageView.moa.url != nil { return } // Download has already started
    
    print("Downloading image \(url)")
    imageView.moa.url = url
  }
  
  /// Cancel current image download HTTP request.
  func cancelDownload() {
    // Cancel current download by setting url to nil
    imageView.moa.url = nil
  }
}