import UIKit

final class TheAuk: TheAukInterface {
  private weak var scrollView: UIScrollView?
  
  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
  }
  
  func show(#image: UIImage) {
    let view = TheAukView()
    scrollView?.addSubview(view)
    view.show(image: image)
  }
  
  func show(#url: String) {
    
  }
}