import UIKit
import XCTest
@testable import Auk

/// Test helpers
extension XCTestCase {
  func nsDataFromFile(_ name: String) -> Data {
    let url = Bundle(for: type(of: self)).url(forResource: name, withExtension: nil)
    return (try! Data(contentsOf: url!))
  }
  
  func createImage35px() -> UIImage {
    return uiImageFromFile("35px.jpg")
  }
  
  func createImage67px() -> UIImage {
    return uiImageFromFile("67px.png")
  }
  
  func createImage96px() -> UIImage {
    return uiImageFromFile("96px.png")
  }
  
  private func uiImageFromFile(_ name: String) -> UIImage {
    return UIImage(data: nsDataFromFile(name))!
  }
  
  /**
  
  - returns: Array of scroll view pages.
  
  */
  func aukPages(_ scrollView: UIScrollView) -> [AukPage] {
    return AukScrollViewContent.aukPages(scrollView)
  }
  
  /**

  - returns: The the AukPage with given index.
  
  */
  func aukPage(_ scrollView: UIScrollView, pageIndex: Int) -> AukPage? {
    let views = aukPages(scrollView)
    if views.count < pageIndex + 1 { return nil }
    return views[pageIndex]
  }
  
  /**
   
  - returns: The number of images on the given page. A page can show a placeholder image and a normal image on top.
   
  */
  func numberOfImagesOnPage(_ scrollView: UIScrollView, pageIndex: Int) -> Int {
    guard let view = aukPage(scrollView, pageIndex: pageIndex) else { return 123 }
    let imgesViews = view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }
    
    return imgesViews.filter { $0.image != nil }.count
  }
  
  /**
  
  - returns: The first image view form the AukPage with given index. A page can show a placeholder image and a normal image on top.
  
  */
  func firstAukImageView(_ scrollView: UIScrollView, pageIndex: Int) -> UIImageView? {
    if let view = aukPage(scrollView, pageIndex: pageIndex) {
      return view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }.first
    }
    
    return nil
  }
  
  /**
  
  - returns: The second image view form the AukPage with given index. A page can show a placeholder image and a normal image on top.
  
  */
  func secondAukImageView(_ scrollView: UIScrollView, pageIndex: Int) -> UIImageView? {
    if let view =  aukPage(scrollView, pageIndex: pageIndex) {
      return view.subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }[1]
    }
    
    return nil
  }
  
  /**
  
  - returns: The first image the TheAukPage with given index. A page can show a placeholder image and a normal image on top.
  
  */
  func firstAukImage(_ scrollView: UIScrollView, pageIndex: Int) -> UIImage? {
    return firstAukImageView(scrollView, pageIndex: pageIndex)?.image
  }
  
  /**
   
   - returns: The width of the first image the TheAukPage with given index.
   
   */
  func firstAukImageWidth(_ scrollView: UIScrollView, pageIndex: Int) -> CGFloat {
    return firstAukImage(scrollView, pageIndex: pageIndex)!.size.width
  }
  
  /**
  
  - returns: The second image the TheAukPage with given index. A page can show a placeholder image and a normal image on top.
  
  */
  func secondAukImage(_ scrollView: UIScrollView, pageIndex: Int) -> UIImage? {
    return secondAukImageView(scrollView, pageIndex: pageIndex)?.image
  }
  
  /**
   
   - returns: The width of the second image the TheAukPage with given index.
   
   */
  func secondAukImageWidth(_ scrollView: UIScrollView, pageIndex: Int) -> CGFloat {
    return secondAukImage(scrollView, pageIndex: pageIndex)!.size.width
  }
}
