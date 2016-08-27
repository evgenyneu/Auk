import UIKit

/**
 
Collection of static function for animation.
 
*/
class iiAnimator {
  // The object used for animation. This property is nil usually. In unit tests it contains a fake animator.
  static var currentAnimator: iiAnimator?
  
  // The object used for animation.
  static var animator: iiAnimator {
    get {
      return currentAnimator ?? iiAnimator()
    }
  }
  
  /// Animation function. This is a wrapper around UIView.animate to make it easier to unit test.
  func animate(name: String, withDuration duration: TimeInterval, animations: @escaping ()->(), completion: ((Bool)->())? = nil) {
    UIView.animate(withDuration: duration,
                   animations: animations,
                   completion: completion
    )
  }
  
  
  
  /**
  
  Fades out the view.
  
  - parameter view: View to fade out.
   
  - parameter animated: animates the fade out then true. Fades out immediately when false.
   
  - parameter withDuration: Duration of the fade out animation in seconds.
   
  - parameter completion: function to be called when the fade out animation is finished. Called immediately when not animated.
   
  */
  static func fadeOut(view: UIView, animated: Bool, withDuration duration: TimeInterval, completion: @escaping ()->()) {
    if animated {
      animator.animate(name: "Fade out", withDuration: duration,
        animations: {
          view.alpha = 0
        },
        completion: { _ in
           completion()
        }
      )
    } else {
      completion()
    }
  }
}
