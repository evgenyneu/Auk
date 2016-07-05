@testable import Auk

/// A helper class for running fake animations in unit tests
class iiFakeAnimator: iiAnimator {
  // Array of durations
  var testDurations = [TimeInterval]()
  
  // Array of animation functions
  var testAnimations = [(()->())]()
  
  // Array of completion functions
  var testCompletions = [((Bool)->())?]()
  
  /// A fake animation function that will be called instead of the real one in unit tests
  override func animate(withDuration duration: TimeInterval, animations: ()->(), completion: ((Bool)->())? = nil) {
    testDurations.append(duration)
    testAnimations.append(animations)
    testCompletions.append(completion)
  }
}
