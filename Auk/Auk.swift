import UIKit

final class Auk: AukInterface {
  private weak var scrollView: UIScrollView?
  
  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
  }
  
  func show(#image: UIImage) {
    let view = AukView()
    
    if let scrollView = scrollView {
      scrollView.addSubview(view)
      AukScrollViewContent.layout(scrollView)
      view.show(image: image)
    }
  }
  
  func show(#url: String) {
    
  }
}