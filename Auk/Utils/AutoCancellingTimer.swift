//
// Creates a timer that executes code after delay. The timer lives in an instance of `AutoCancellingTimer` class and is automatically canceled when this instance is deallocated.
// This is an auto-canceling alternative to timer created with `dispatch_after` function.
//
// Source: https://gist.github.com/evgenyneu/516f7dcdb5f2f73d
//
// Usage
// -----
//     
//     class MyClass {
//         var timer: AutoCancellingTimer? // Timer will be cancelled with MyCall is deallocated
//
//         func runTimer() {
//             timer = AutoCancellingTimer(interval: delaySeconds, repeats: true) {
//                ... code to run
//             }
//         }
//     }
//
//
//  Cancel the timer
//  --------------------
//
//  Timer is canceled automatically when it is deallocated. You can also cancel it manually:
//
//     timer.cancel()
//

import UIKit

final class AutoCancellingTimer {
  private var timer: AutoCancellingTimerInstance?
  
  init(interval: NSTimeInterval, repeats: Bool = false, callback: ()->()) {
    timer = AutoCancellingTimerInstance(interval: interval, repeats: repeats, callback: callback)
  }
  
  deinit {
    timer?.cancel()
  }
  
  func cancel() {
    timer?.cancel()
  }
}

final class AutoCancellingTimerInstance: NSObject {
  private let repeats: Bool
  private var timer: NSTimer?
  private var callback: ()->()
  
  init(interval: NSTimeInterval, repeats: Bool = false, callback: ()->()) {
    self.repeats = repeats
    self.callback = callback
    
    super.init()
    
    timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self,
      selector: "timerFired:", userInfo: nil, repeats: repeats)
  }
  
  func cancel() {
    timer?.invalidate()
  }
  
  func timerFired(timer: NSTimer) {
    self.callback()
    if !repeats { cancel() }
  }
}