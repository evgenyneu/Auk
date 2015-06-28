import UIKit

/**

Settings for tuning the appearance and function of the auk image scroll view.

*/
public struct AukSettings {
  
  /// Determines the stretching and scaling of the image when its proportion are not the same as its  container
  public var contentMode = UIViewContentMode.ScaleAspectFit
  
  /// Show horizontal scroll indicator.
  public var showsHorizontalScrollIndicator = false
  
  /// Enable paging for the scroll view. When true the view automatically scroll to show the whole image.
  public var pagingEnabled = true
  
  /// Settings for styling the scroll view page indicator.
  public var pageControl = PageControl()
  
  /// Image to be displayed while the remote image is being downloaded.
  public var placeholderImage: UIImage?
  
  /// The length of the animation that is used to show the remote images.
  public var remoteImageAnimationIntervalSeconds: Double = 1
}

/**

Settings for page indicator.

*/
public struct PageControl {
  /// Corner radius of page control container view.
  public var cornerRadius: Double = 15
  
  /// Background color of the page control container view.
  public var backgroundColor = UIColor(red: 128/256, green: 128/256, blue: 128/256, alpha: 0.4)
  
  /// Distance between the bottom of the page control view and the bottom of the scroll view
  public var marginToScrollViewBottom: Double = 5
  
  /// Padding between page indicator and its container
  public var innerPadding = CGSize(width: 10, height: -5)
  
  /// Color of the page indicator dot.
  public var pageIndicatorTintColor: UIColor? = nil
  
  /// Color of the dot representing for the current page.
  public var currentPageIndicatorTintColor: UIColor? = nil
}