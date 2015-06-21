import UIKit
import XCTest

class AukRemoteImageTests: XCTestCase {
  
  var obj: AukRemoteImage!
  var imateView: UIImageView!
  
  override func setUp() {
    super.setUp()
    
    imateView = UIImageView()
    obj = AukRemoteImage(url: "http://site.com/auk.jpg", imageView: imateView)
  }
  
  func testDownload() {
    obj.downloadImage()
  }
}