import UIKit

/**
 
Collection of static function for animation.
 
*/
class iiAnimation {
  /**
  
  Fades out the view.
  
  - parameter view: View to fade out.
   
  - parameter animated: animates the fade out then true. Fades out immediately when false.
   
  - parameter withDuration: Duration of the fade out animation in seconds.
   
  - parameter didFinish: function to be called when the fade out animation is finished. Called immediately when not animated.
   
  */
  static func fadeOut(view: UIView, animated: Bool, withDuration duration: TimeInterval, didFinish: ()->()) {
    if animated {
      UIView.animate(withDuration: duration,
        animations: {
          view.alpha = 0
        },
        completion: { _ in
           didFinish()
        }
      );
    } else {
      didFinish()
    }
  }
}
