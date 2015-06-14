import UIKit

final class Auk: AukInterface {
  private weak var scrollView: UIScrollView?
  
  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
  }
  
  func show(#image: UIImage) {
    let view = AukView()
    scrollView?.addSubview(view)
    view.show(image: image)
  }
  
  func show(#url: String) {
    
  }
}