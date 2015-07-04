//
// Creates a timer that executes code after delay. The timer lives in an instance of `MoaTimer` class and is automatically canceled when this instance is deallocated.
// This is an auto-canceling alternative to timer created with `dispatch_after` function.
//
// Source: https://gist.github.com/evgenyneu/516f7dcdb5f2f73d
//
// Usage
// -----
//   var timer: MoaTimer? // Strong reference
//   ...
//
//   func myFunc() {
//     timer = MoaTimer.runAfter(0.010) { timer in
//        ... code to run
//     }
//   }
//
//
//  Cancel the timer
//  --------------------
//
//  Timer is canceled automatically when it is deallocated. You can also cancel it manually:
//
//  let timer = MoaTimer.runAfter(0.010) { timer in
//    timer.cancel()
//  }
//
//
//

import UIKit

final class MoaTimer: NSObject {
  private let repeats: Bool
  private var timer: NSTimer?
  private var callback: ((MoaTimer)->())?
  
  private init(interval: NSTimeInterval, repeats: Bool = false, callback: (MoaTimer)->()) {
    self.repeats = repeats
    
    super.init()
    
    self.callback = callback
    timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self,
      selector: "timerFired:", userInfo: nil, repeats: repeats)
  }
  
  deinit {
    cancel()
  }
  
  func cancel() {
    timer?.invalidate()
    timer = nil
  }
  
  func timerFired(timer: NSTimer) {
    self.callback?(self)
    if !repeats { cancel() }
  }
  
  class func runAfter(interval: NSTimeInterval, repeats: Bool = false,
    callback: (MoaTimer)->()) -> MoaTimer {
      
      return MoaTimer(interval: interval, repeats: repeats, callback: callback)
  }
}