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
  public var auk: AukInterface {
    get {
      if let value = objc_getAssociatedObject(self, &xoAukAssociationKey) as? AukInterface {
        return value
      } else {
        let auk = Auk(scrollView: self)
        
        objc_setAssociatedObject(self, &xoAukAssociationKey, auk,
          objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
        
        return auk
      }
    }
    
    set {
      objc_setAssociatedObject(self, &xoAukAssociationKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN))
    }
  }
}