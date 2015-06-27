import UIKit
import moa

/**

Downloads and shows remote image.

*/
struct AukRemoteImage {
  let url: String
  let imageView: UIImageView
  
  func downloadImage() {
    imageView.moa.url = url
  }
}