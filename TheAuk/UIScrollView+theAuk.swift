import UIKit

private var xoTheAukAssociationKey: UInt8 = 0

/**

Scroll view extension for showing series of images with paging indicator.

*/
public extension UIScrollView {
  /**
  
  Scroll view extension for showing series of images with paging indicator.
  Call its `show` method to show an image in the scroll view.
  
  */
  public var theAuk: TheAuk {
    get {
      if let value = objc_getAssociatedObject(self, &xoTheAukAssociationKey) as? TheAuk {
        return value
      } else {
        let theAuk = TheAuk(scrollView: self)
        
        objc_setAssociatedObject(self, &xoTheAukAssociationKey, theAuk,
          objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        
        return theAuk
      }
    }
    
    set {
      objc_setAssociatedObject(self, &xoTheAukAssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
    }
  }
}