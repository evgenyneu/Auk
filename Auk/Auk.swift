import UIKit

final class Auk: AukInterface {
  private weak var scrollView: UIScrollView?
  
  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
  }
  
  func show(#image: UIImage) {
    let settings = AukSettings()
    let view = AukView()
    
    if let scrollView = scrollView {
      scrollView.addSubview(view)
      AukScrollViewContent.layout(scrollView)
      view.show(image: image, settings: settings)
    }
  }
  
  func show(#url: String) {
    
  }
}