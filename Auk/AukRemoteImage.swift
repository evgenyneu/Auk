import UIKit
import moa

/**

Downloads and shows a single remote image.

*/
struct AukRemoteImage {
  let url: String
  let imageView: UIImageView
  
  func downloadImage() {
    if imageView.moa.url != nil { return } // Download has already started
    imageView.moa.url = url
  }
}