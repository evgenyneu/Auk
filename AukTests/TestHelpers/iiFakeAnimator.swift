@testable import Auk

/// A helper class for running fake animations in unit tests
class iiFakeAnimator: iiAnimator {
  // Array of animation functions
  var testParameters = [iiFakeAnimatorParameter]()
  
  /// A fake animation function that will be called instead of the real one in unit tests
  override func animate(name: String, withDuration duration: TimeInterval, animations: @escaping ()->(), completion: ((Bool)->())? = nil) {
    
    let parameter = iiFakeAnimatorParameter(name: name, duration: duration,
                                            animation: animations, completion: completion)
   
    testParameters.append(parameter)
  }
}
