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
      
    let pageIndex = scrollView.auk.pageIndex
      
    coordinator.animateAlongsideTransition({ [weak self] _ in
      self?.scrollView.auk.changePage(pageIndex, pageWidth: size.width)
      
//      self?.scrollView.contentOffset.x = size.width

    }, completion: nil)
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

