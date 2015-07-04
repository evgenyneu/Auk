import UIKit
import Auk
import moa

class ViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.auk.settings.placeholderImage = UIImage(named: "great_auk_placeholder.png")
    scrollView.auk.settings.errorImage = UIImage(named: "error_image.png")
  }
  
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
      
    let pageIndex = scrollView.auk.currentPageIndex
    
    coordinator.animateAlongsideTransition({ [weak self] _ in
      self?.scrollView.auk.scrollTo(pageIndex, pageWidth: size.width, animated: false)
    }, completion: nil)
  }
  
  @IBAction func onShowLocalTapped(sender: AnyObject) {
    for imageName in DemoConstants.localImageNames {
      if let image = UIImage(named: imageName) {
        scrollView.auk.show(image: image)
      }
    }
  }
  
  @IBAction func onShowRemoteTapped(sender: AnyObject) {
    for imageName in DemoConstants.remoteImageNames {
      let url = "\(DemoConstants.remoteImageBaseUrl)\(imageName)"
      scrollView.auk.show(url: url)
    }
  }
  
  @IBAction func onNextPageTapped(sender: AnyObject) {
    scrollView.auk.scrollToNextPage()
  }
  
  @IBAction func onPreviousPageTapped(sender: AnyObject) {
    scrollView.auk.scrollToPreviousPage()

  }
  
  @IBAction func onDeleteButtonTapped(sender: AnyObject) {
    scrollView.auk.removeAll()
  }
  
  @IBAction func onAutoscrollTapped(sender: AnyObject) {
    
    scrollView.auk.startAutoScroll(delaySeconds: 2)
  }
}

