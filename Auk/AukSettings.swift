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
}