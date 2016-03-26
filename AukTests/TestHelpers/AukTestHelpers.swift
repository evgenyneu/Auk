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
   
  - returns: The number of images on the given page. A page can show a placeholder image and a normal image on top.
   
  */
  func numberOfImagesOnPage(scrollView: UIScrollView, pageIndex: Int) -> Int {
    guard let view = aukPage(scrollView, pageIndex: pageIndex) else { return 123 }
    let imgesViews = view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }
    
    return imgesViews.filter { $0.image != nil }.count
  }
  
  /**
  
  - returns: The first image view form the AukPage with given index. A page can show a placeholder image and a normal image on top.
  
  */
  func firstAukImageView(scrollView: UIScrollView, pageIndex: Int) -> UIImageView? {
    if let view = aukPage(scrollView, pageIndex: pageIndex) {
      return view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }.first
    }
    
    return nil
  }
  
  /**
  
  - returns: The second image view form the AukPage with given index. A page can show a placeholder image and a normal image on top.
  
  */
  func secondAukImageView(scrollView: UIScrollView, pageIndex: Int) -> UIImageView? {
    if let view =  aukPage(scrollView, pageIndex: pageIndex) {
      return view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }[1]
    }
    
    return nil
  }
  
  /**
  
  - returns: The first image the TheAukPage with given index. A page can show a placeholder image and a normal image on top.
  
  */
  func firstAukImage(scrollView: UIScrollView, pageIndex: Int) -> UIImage? {
    return firstAukImageView(scrollView, pageIndex: pageIndex)?.image
  }
  
  /**
  
  - returns: The second image the TheAukPage with given index. A page can show a placeholder image and a normal image on top.
  
  */
  func secondAukImage(scrollView: UIScrollView, pageIndex: Int) -> UIImage? {
    return secondAukImageView(scrollView, pageIndex: pageIndex)?.image
  }
}