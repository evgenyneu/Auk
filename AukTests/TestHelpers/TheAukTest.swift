import UIKit
import XCTest

/// Test helpers
extension XCTestCase {
  func nsDataFromFile(name: String) -> NSData {
    let url = NSBundle(forClass: self.dynamicType).URLForResource(name, withExtension: nil)!
    return NSData(contentsOfURL: url)!
  }
  
  func uiImageFromFile(name: String) -> UIImage {
    return UIImage(data: nsDataFromFile(name))!
  }
  
  /**
  
  :returns: Array of TheAukView objects that are subviews of the given superview.
  
  */
  func theAukViews(superview: UIView) -> [TheAukView] {
    return superview.subviews.filter { $0 is TheAukView }.map { $0 as! TheAukView }
  }
  
  /**

  :returns: The the TheAukView with given index.
  
  */
  func theAukView(superview: UIView, index: Int) -> TheAukView? {
    let aukViews = theAukViews(superview)
    if aukViews.count < index + 1 { return nil }
    return aukViews[index]
  }
  
  /**
  
  :returns: The the first image view form the TheAukView with given index.
  
  */
  func firstAukImageView(superview: UIView, index: Int) -> UIImageView? {
    if let view =  theAukView(superview, index: index) {
      return view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }.first
    }
    
    return nil
  }
  
  /**
  
  :returns: The the first image the TheAukView with given index.
  
  */
  func firstAukImage(superview: UIView, index: Int) -> UIImage? {
    return firstAukImageView(superview, index: index)?.image
  }
}