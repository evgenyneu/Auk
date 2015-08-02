import UIKit
import XCTest
@testable import Auk

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
  
  - returns: Array of scroll view pages.
  
  */
  func aukPages(scrollView: UIScrollView) -> [AukPage] {
    return AukScrollViewContent.aukPages(scrollView)
  }
  
  /**

  - returns: The the AukPage with given index.
  
  */
  func aukPage(scrollView: UIScrollView, pageIndex: Int) -> AukPage? {
    let views = aukPages(scrollView)
    if views.count < pageIndex + 1 { return nil }
    return views[pageIndex]
  }
  
  /**
  
  - returns: The the first image view form the AukPage with given index.
  
  */
  func firstAukImageView(scrollView: UIScrollView, pageIndex: Int) -> UIImageView? {
    if let view = aukPage(scrollView, pageIndex: pageIndex) {
      return view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }.first
    }
    
    return nil
  }
  
  /**
  
  - returns: The the second image view form the AukPage with given index.
  
  */
  func secondAukImageView(scrollView: UIScrollView, pageIndex: Int) -> UIImageView? {
    if let view =  aukPage(scrollView, pageIndex: pageIndex) {
      return view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }[1]
    }
    
    return nil
  }
  
  /**
  
  - returns: The the first image the TheAukPage with given index.
  
  */
  func firstAukImage(superview: UIScrollView, pageIndex: Int) -> UIImage? {
    return firstAukImageView(superview, pageIndex: pageIndex)?.image
  }
  
  /**
  
  - returns: The the first image the TheAukPage with given index.
  
  */
  func secondAukImage(superview: UIScrollView, pageIndex: Int) -> UIImage? {
    return secondAukImageView(superview, pageIndex: pageIndex)?.image
  }
}