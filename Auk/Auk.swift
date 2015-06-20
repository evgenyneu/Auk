import UIKit

final class Auk: AukInterface {
  private weak var scrollView: UIScrollView?
  var settings = AukSettings()

  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
  }
  
  func setup() {
    scrollView?.showsHorizontalScrollIndicator = settings.showsHorizontalScrollIndicator
    scrollView?.pagingEnabled = settings.pagingEnabled
  }
  
  func show(#image: UIImage) {
    setup()
    
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