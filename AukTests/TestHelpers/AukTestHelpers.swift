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
  
  :returns: Array of AukView objects that are subviews of the given scroll view.
  
  */
  func aukViews(scrollView: UIScrollView) -> [AukView] {
    return AukScrollViewContent.aukViews(scrollView)
  }
  
  /**

  :returns: The the AukView with given index.
  
  */
  func aukView(scrollView: UIScrollView, index: Int) -> AukView? {
    let views = aukViews(scrollView)
    if views.count < index + 1 { return nil }
    return views[index]
  }
  
  /**
  
  :returns: The the first image view form the AukView with given index.
  
  */
  func firstAukImageView(scrollView: UIScrollView, index: Int) -> UIImageView? {
    if let view =  aukView(scrollView, index: index) {
      return view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }.first
    }
    
    return nil
  }
  
  /**
  
  :returns: The the first image the TheAukView with given index.
  
  */
  func firstAukImage(superview: UIScrollView, index: Int) -> UIImage? {
    return firstAukImageView(superview, index: index)?.image
  }
}