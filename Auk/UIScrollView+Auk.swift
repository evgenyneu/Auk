import UIKit

private var xoAukAssociationKey: UInt8 = 0

/**

Scroll view extension for showing series of images with paging indicator.

*/
public extension UIScrollView {
  /**
  
  Scroll view extension for showing series of images with paging indicator.
  Call its `show` method to show an image in the scroll view.
  
  */
  public var auk: TheAukInterface {
    get {
      if let value = objc_getAssociatedObject(self, &xoAukAssociationKey) as? TheAukInterface {
        return value
      } else {
        let theAuk = Auk(scrollView: self)
        
        objc_setAssociatedObject(self, &xoAukAssociationKey, theAuk,
          objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        
        return theAuk
      }
    }
    
    set {
      objc_setAssociatedObject(self, &xoAukAssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
    }
  }
}