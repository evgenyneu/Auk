import UIKit
import Auk

class ViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var showLocalButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    styleButtons([showLocalButton])
  }
  
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
      
    coordinator.animateAlongsideTransition(nil) { [weak self] _ in
      self?.scrollView.auk.showViews()
    }
      
    updateScrollViewContent(size)
  }
  
  private func updateScrollViewContent(newSize: CGSize) {
    let size = CGSize(width: newSize.width, height: scrollView.bounds.size.height)
    scrollView.auk.hideAllViewsExceptCurrent()
    scrollView.auk.relayout(size)
  }
  
  private func styleButtons(buttons: [UIView]) {
    for button in buttons {
      button.layer.borderWidth = DemoConstants.button.borderWidth
      button.layer.borderColor = DemoConstants.button.borderColor.CGColor
      button.layer.cornerRadius = DemoConstants.button.cornerRadius
    }
  }
  
  @IBAction func onShowLocalTapped(sender: AnyObject) {
    for imageName in DemoConstants.localImageNames {
      if let image = UIImage(named: imageName) {
        scrollView.auk.show(image: image)
      }
    }
  }
}

