import UIKit
import Auk
import moa

class ViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  
  var imageDescriptions = [String]()
  @IBOutlet weak var imageDescriptionLabel: UILabel!
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.delegate = self
    scrollView.auk.settings.placeholderImage = UIImage(named: "great_auk_placeholder.png")
    scrollView.auk.settings.errorImage = UIImage(named: "error_image.png")

    showInitialImage()
    updateCurrentImageDescription()
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
    for localImage in DemoConstants.localImages {
      if let image = UIImage(named: localImage.fileName) {
        scrollView.auk.show(image: image, accessibilityLabel: localImage.description)
        imageDescriptions.append(localImage.description)
      }
    }
    
    updateCurrentImageDescription()
  }

  @IBAction func onShowRemoteTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    for remoteImage in DemoConstants.remoteImages {
      let url = "\(DemoConstants.remoteImageBaseUrl)\(remoteImage.fileName)"
      scrollView.auk.show(url: url, accessibilityLabel: remoteImage.description)
      
      imageDescriptions.append(remoteImage.description)
    }
    
    updateCurrentImageDescription()
  }

  @IBAction func onShowRightButtonTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    
    if RightToLeft.isRightToLeft(view) {
      scrollView.auk.scrollToPreviousPage()
    } else {
      scrollView.auk.scrollToNextPage()
    }
  }

  @IBAction func onShowLeftButtonTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    
    if RightToLeft.isRightToLeft(view) {
      scrollView.auk.scrollToNextPage()
    } else {
      scrollView.auk.scrollToPreviousPage()
    }
  }

  @IBAction func onDeleteButtonTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    scrollView.auk.removeAll()
    imageDescriptions = []
    updateCurrentImageDescription()
  }

  @IBAction func onAutoscrollTapped(sender: AnyObject) {
    scrollView.auk.startAutoScroll(delaySeconds: 2)
  }

  private func showInitialImage() {
    if let image = UIImage(named: DemoConstants.initialImage.fileName) {
      scrollView.auk.show(image: image,
        accessibilityLabel: DemoConstants.initialImage.description)
      
      imageDescriptions.append(DemoConstants.initialImage.description)
    }
  }
  
  private func updateCurrentImageDescription() {
    if let description = currentImageDescription {
      imageDescriptionLabel.text = description
    } else {
      imageDescriptionLabel.text = nil
    }
  }
  
  private var currentImageDescription: String? {
    if scrollView.auk.currentPageIndex >= imageDescriptions.count {
      return nil
    }
    
    return imageDescriptions[scrollView.auk.currentPageIndex]
  }
  
  // MARK: - UIScrollViewDelegate
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    updateCurrentImageDescription()
  }
}

