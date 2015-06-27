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
  
  :returns: Array of scroll view pages.
  
  */
  func aukPages(scrollView: UIScrollView) -> [AukPage] {
    return AukScrollViewContent.aukPages(scrollView)
  }
  
  /**

  :returns: The the AukPage with given index.
  
  */
  func aukPage(scrollView: UIScrollView, index: Int) -> AukPage? {
    let views = aukPages(scrollView)
    if views.count < index + 1 { return nil }
    return views[index]
  }
  
  /**
  
  :returns: The the first image view form the AukPage with given index.
  
  */
  func firstAukImageView(scrollView: UIScrollView, index: Int) -> UIImageView? {
    if let view =  aukPage(scrollView, index: index) {
      return view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }.first
    }
    
    return nil
  }
  
  /**
  
  :returns: The the first image the TheAukPage with given index.
  
  */
  func firstAukImage(superview: UIScrollView, index: Int) -> UIImage? {
    return firstAukImageView(superview, index: index)?.image
  }
}