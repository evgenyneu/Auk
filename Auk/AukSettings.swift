import UIKit

/**

Settings for tuning the appearance and function of the auk image scroll view.

*/
struct AukSettings {
  
  /// Determines the stretching and scaling of the image when its proportion are not the same as its  container
  var contentMode = UIViewContentMode.ScaleAspectFit
  
  /// Show horizontal scroll indicator.
  var showsHorizontalScrollIndicator = false
  
  /// Enable paging for the scroll view. When true the view automatically scroll to show the whole image.
  var pagingEnabled = true
  
  var pageControl = PageControl()
}


/**

Settings for page control indicator, the one that indicates how many pages are in scroll view with nice little dots.

*/
struct PageControl {
  /// Corner radius of page control container view.
  var cornerRadius: Double = 15
  
  /// Background color of the page control container view.
  var backgroundColor = UIColor(red: 128/256, green: 128/256, blue: 128/256, alpha: 0.4)
  
  /// Distance between the bottom of the page control view and the bottom of the scroll view
  var marginToScrollViewBottom: Double = 5
  
  /// Padding between page indicator and its container
  var innerPadding = CGSize(width: 10, height: -5)
  
  /// Color of the page indicator dot.
  var pageIndicatorTintColor: UIColor? = nil
  
  /// Color of the dot representing for the current page.
  var currentPageIndicatorTintColor: UIColor? = nil
}