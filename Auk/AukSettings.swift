import UIKit

/**

Appearance and behavior of the scroll view.

*/
public struct AukSettings {
  
  /// Determines the stretching and scaling of the image when its proportion are not the same as its  container.
  public var contentMode = UIViewContentMode.scaleAspectFit
  
  /// Image to be displayed when remote image download fails.
  public var errorImage: UIImage?
  
  /// Settings for styling the scroll view page indicator.
  public var pageControl = PageControlSettings()
  
  /// Enable paging for the scroll view. When true the view automatically scrolls to show the whole image.
  public var pagingEnabled = true
  
  /// Image to be displayed while the remote image is being downloaded.
  public var placeholderImage: UIImage?
  
  /**
   
  The number of remote images to preload around the current page. For example, if preloadRemoteImagesAround = 2 and we are viewing the first page it will preload images on the second and third pages. If we are viewing 5th page then it will preload images on pages 3, 4, 6 and 7 (unless they are already loaded). The default value is 0, i.e. it only loads the image for the currently visible pages.
   
  */
  public var preloadRemoteImagesAround = 0
  
  /// The duration of the animation that is used to show the remote images.
  public var remoteImageAnimationIntervalSeconds: Double = 0.5
  
  // Duration of the fade out animation when the page is removed.
  public var removePageFadeOutAnimationDurationSeconds: Double = 0.2
  
  // Duration of the layout animation when the page is removed.
  public var removePageLayoutAnimationDurationSeconds: Double = 0.3
  
  /// Show horizontal scroll indicator.
  public var showsHorizontalScrollIndicator = false
}

/**

Settings for page indicator.

*/
public struct PageControlSettings {
  /// Background color of the page control container view.
  public var backgroundColor = UIColor(red: 128/256, green: 128/256, blue: 128/256, alpha: 0.4)
  
  /// Corner radius of page control container view.
  public var cornerRadius: Double = 13
  
  /// Color of the dot representing for the current page.
  public var currentPageIndicatorTintColor: UIColor? = nil
  
  /// Padding between page indicator and its container
  public var innerPadding = CGSize(width: 10, height: -5)
  
  /// Distance between the bottom of the page control view and the bottom of the scroll view.
  public var marginToScrollViewBottom: Double = 8
  
  /// Color of the page indicator dot.
  public var pageIndicatorTintColor: UIColor? = nil
  
  /// When true the page control is visible on screen.
  public var visible = true
}
