import UIKit
import Auk
import moa

class ViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.auk.settings.placeholderImage = UIImage(named: "great_auk_placeholder.png")
    scrollView.auk.settings.errorImage = UIImage(named: "error_image.png")

    showInitialImage()
  }

  /// Animate scroll view on orientation change
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {

    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)

    let pageIndex = scrollView.auk.currentPageIndex
    let newScrollViewWidth = size.width // Assuming scroll view occupies 100% of the screen width

    coordinator.animateAlongsideTransition({ [weak self] _ in
      self?.scrollView.auk.scrollTo(pageIndex, pageWidth: newScrollViewWidth, animated: false)
    }, completion: nil)
  }
  
  /// Animate scroll view on orientation change
  /// Support iOS 7 and older
  override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation,
    duration: NSTimeInterval) {
      
    super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
    
    var screenWidth = UIScreen.mainScreen().bounds.height
    if UIInterfaceOrientationIsPortrait(toInterfaceOrientation) {
      screenWidth = UIScreen.mainScreen().bounds.width
    }
    
    let pageIndex = scrollView.auk.currentPageIndex
    scrollView.auk.scrollTo(pageIndex, pageWidth: screenWidth, animated: false)
  }

  @IBAction func onShowLocalTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    for imageName in DemoConstants.localImageNames {
      if let image = UIImage(named: imageName) {
        scrollView.auk.show(image: image)
      }
    }
  }

  @IBAction func onShowRemoteTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    for imageName in DemoConstants.remoteImageNames {
      let url = "\(DemoConstants.remoteImageBaseUrl)\(imageName)"
      scrollView.auk.show(url: url)
    }
  }

  @IBAction func onNextPageTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    scrollView.auk.scrollToNextPage()
  }

  @IBAction func onPreviousPageTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    scrollView.auk.scrollToPreviousPage()
  }

  @IBAction func onDeleteButtonTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    scrollView.auk.removeAll()
  }

  @IBAction func onAutoscrollTapped(sender: AnyObject) {
    scrollView.auk.startAutoScroll(delaySeconds: 2)
  }

  private func showInitialImage() {
    if let image = UIImage(named: DemoConstants.initialImagName) {
      scrollView.auk.show(image: image)
    }
  }
}

