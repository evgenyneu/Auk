import UIKit
import XCTest


extension XCTestCase {
  func nsDataFromFile(name: String) -> NSData {
    let url = NSBundle(forClass: self.dynamicType).URLForResource(name, withExtension: nil)!
    return NSData(contentsOfURL: url)!
  }
  
  func uiImageFromFile(name: String) -> UIImage {
    return UIImage(data: nsDataFromFile(name))!
  }
  
  func theAukViews(superview: UIView) -> [TheAukView] {
    return superview.subviews.filter { $0 is TheAukView }.map { $0 as! TheAukView }
  }
}