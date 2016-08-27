//
//  iiQueue.swift
//
//  Shortcut functions to run code in asynchronously and in main queue
//
//  Created by Evgenii Neumerzhitckii on 11/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class iiQ {
  class func async(_ block: @escaping ()->()) {
    DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: block)
  }

  class func main(_ block: @escaping ()->()) {
    DispatchQueue.main.async(execute: block)
  }

  class func runAfterDelay(_ delaySeconds: Double, block: @escaping ()->()) {
    let time = DispatchTime.now() + Double(Int64(delaySeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time, execute: block)
  }
}
