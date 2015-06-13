import UIKit

/**

Shows images in the scroll view with paging indicator.

Call its `show` method to show an image in the scroll view.

*/
public final class TheAuk {
  private var scrollView: UIScrollView?
  
  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
  }
  
  init() { }
}