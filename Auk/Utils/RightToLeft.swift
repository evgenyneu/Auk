import UIKit

/**

Helper functions for dealing with right-to-left languages.

*/
struct RightToLeft {
  static func isRightToLeft(view: UIView) -> Bool {
    if #available(iOS 9.0, *) {
      return UIView.userInterfaceLayoutDirectionForSemanticContentAttribute(
        view.semanticContentAttribute) == .RightToLeft
    } else {
      return UIApplication.sharedApplication().userInterfaceLayoutDirection == .RightToLeft
    }
  }
}
