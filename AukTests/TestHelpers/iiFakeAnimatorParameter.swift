import UIKit

// Parameters passed to the fake animator. Used in unit tests to verify animation
struct iiFakeAnimatorParameter {
  // Arbitrary name of the animation
  var name: String
  
  // Animation duration
  var duration: TimeInterval
  
  // A function passed to the animator
  var animation: ()->()
  
  // A completion function passed to the animator
  var completion: ((Bool)->())?
}
