import UIKit

/**
 
 This is a sample file that can be used in your ObjC project if you want to use Auk Swift library.
 Extend this file to add other functionality for your app.
 
 How to use
 ----------
 
 1. Import swift code in your ObjC file:
 
 #import "YOUR_PRODUCT_MODULE_NAME-Swift.h"
 
 2. Use Auk in your ObjC code:
 
 - (void)viewDidLoad {
    [super viewDidLoad];
 
    [AukObjCBridge setupWithScrollView: self.scrollView];
    [AukObjCBridge showWithUrl: @"https://bit.ly/auk_image" inScrollView: self.scrollView];
    [AukObjCBridge showWithUrl: @"https://bit.ly/moa_image" inScrollView: self.scrollView];
 }
*/
@objc public class AukObjCBridge: NSObject {
  /**
   
   Downloads a remote image and adds it to the scroll view. Use `Moa.settings.cache` property to configure image caching.
   
   - parameter url: Url of the image to be shown.
   
   - parameter scrollView: A scroll view where the image will be shown.
   
   
   */
  public class func show(url: String, inScrollView scrollView: UIScrollView) {
    scrollView.auk.show(url: url)
  }
  
  /**
   
   Shows a local image in the scroll view.
   
   - parameter image: Image to be shown in the scroll view.
   
   - parameter scrollView: A scroll view with Auk images to remove.
   
   */
  public class func show(image: UIImage, inScrollView scrollView: UIScrollView) {
    scrollView.auk.show(image: image)
  }
  
  /**
   
   Removes all images from the scroll view.
   
   - parameter scrollView: A scroll view with Auk images to remove.
   
   */
  public class func removeAll(scrollView: UIScrollView) {
    scrollView.auk.removeAll()
  }
  
  /**
   
   Example of a function that changes Auk settings
   
   - parameter scrollView: a scroll view for chaging Auk settings
   
   */
  public class func setup(scrollView: UIScrollView) {
    scrollView.auk.settings.contentMode = UIView.ContentMode.scaleAspectFill
    scrollView.auk.settings.preloadRemoteImagesAround = 1
  }
}
