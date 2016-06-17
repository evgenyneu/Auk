import UIKit

private var xoAukAssociationKey: UInt8 = 0

/**

Scroll view extension for showing series of images with page indicator.


Usage:

    // Show remote image
    scrollView.auk.show(url: "http://site.com/bird.jpg")

    // Show local image
    if let image = UIImage(named: "bird.jpg") {
      scrollView.auk.show(image: image)
    }

*/
public extension UIScrollView {
  /**
  
  Scroll view extension for showing series of images with page indicator.
  
  Usage:
  
      // Show remote image
      scrollView.auk.show(url: "http://site.com/bird.jpg")
      
      // Show local image
      if let image = UIImage(named: "bird.jpg") {
        scrollView.auk.show(image: image)
      }
  
  */
  public var auk: Auk {
    get {
      if let value = objc_getAssociatedObject(self, &xoAukAssociationKey) as? Auk {
        return value
      } else {
        let auk = Auk(scrollView: self)
        
        objc_setAssociatedObject(self, &xoAukAssociationKey, auk,
          objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        return auk
      }
    }
    
    set {
      objc_setAssociatedObject(self, &xoAukAssociationKey, newValue,
        objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
  }
}
