import UIKit

final class TheAuk: TheAukInterface {
  private var scrollView: UIScrollView?
  
  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
  }
  
  init() { }
}