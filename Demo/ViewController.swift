import UIKit
import Auk
import moa

class ViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  
  var imageDescriptions = [String]()
  @IBOutlet weak var imageDescriptionLabel: UILabel!
  
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  @IBOutlet weak var autoScrollButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutButtons()
    
    scrollView.delegate = self
    scrollView.auk.settings.placeholderImage = UIImage(named: "great_auk_placeholder.png")
    scrollView.auk.settings.errorImage = UIImage(named: "error_image.png")
    
    showInitialImage()
    showCurrentImageDescription()
  }
  
  // Show the first image when the app starts
  private func showInitialImage() {
    if let image = UIImage(named: DemoConstants.initialImage.fileName) {
      scrollView.auk.show(image: image,
                          accessibilityLabel: DemoConstants.initialImage.description)
      
      imageDescriptions.append(DemoConstants.initialImage.description)
    }
  }

  // Show local images
  @IBAction func onShowLocalTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    for localImage in DemoConstants.localImages {
      if let image = UIImage(named: localImage.fileName) {
        scrollView.auk.show(image: image, accessibilityLabel: localImage.description)
        imageDescriptions.append(localImage.description)
      }
    }
    
    showCurrentImageDescription()
  }

  // Show remote images
  @IBAction func onShowRemoteTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    for remoteImage in DemoConstants.remoteImages {
      let url =  "\(DemoConstants.remoteImageBaseUrl)\(remoteImage.fileName)"
      scrollView.auk.show(url: url, accessibilityLabel: remoteImage.description)
      
      imageDescriptions.append(remoteImage.description)
    }
    
    showCurrentImageDescription()
  }
  
  // Scroll to the next image
  @IBAction func onShowRightButtonTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    
    if RightToLeft.isRightToLeft(view) {
      scrollView.auk.scrollToPreviousPage()
    } else {
      scrollView.auk.scrollToNextPage()
    }
  }

  // Scroll to the previous image
  @IBAction func onShowLeftButtonTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    
    if RightToLeft.isRightToLeft(view) {
      scrollView.auk.scrollToNextPage()
    } else {
      scrollView.auk.scrollToPreviousPage()
    }
  }

  // Remove all images
  @IBAction func onDeleteButtonTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    scrollView.auk.removeAll()
    imageDescriptions = []
    showCurrentImageDescription()
  }

  @IBAction func onAutoscrollTapped(sender: AnyObject) {
    scrollView.auk.startAutoScroll(delaySeconds: 2)
  }
  
  @IBAction func onScrollViewTapped(sender: AnyObject) {
    imageDescriptionLabel.text = "Tapped image #\(scrollView.auk.currentPageIndex)"
  }
  
  private func layoutButtons() {
    layoutButtons(leftButton, secondView: autoScrollButton)
    layoutButtons(autoScrollButton, secondView: rightButton)
  }
  
  // Use left/right constraints instead of leading/trailing to prevent buttons from changing their place for right-to-left languages.
  private func layoutButtons(firstView: UIView, secondView: UIView) {
    let constraint = NSLayoutConstraint(
      item: secondView,
      attribute: NSLayoutAttribute.Left,
      relatedBy: NSLayoutRelation.Equal,
      toItem: firstView,
      attribute: NSLayoutAttribute.Right,
      multiplier: 1,
      constant: 35)
    
    view.addConstraint(constraint)
  }
  
  // MARK: - Handle orientation change
  
  /// Animate scroll view on orientation change
  override func viewWillTransitionToSize(size: CGSize,
                                         withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    
    guard let pageIndex = scrollView.auk.currentPageIndex else { return }
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
    
    guard let pageIndex = scrollView.auk.currentPageIndex else { return }
    scrollView.auk.scrollTo(pageIndex, pageWidth: screenWidth, animated: false)
  }
  
  // MARK: - Image description
  
  private func showCurrentImageDescription() {
    if let description = currentImageDescription {
      imageDescriptionLabel.text = description
    } else {
      imageDescriptionLabel.text = nil
    }
  }
  
  private func changeCurrentImageDescription(description: String) {
    guard let currentPageIndex = scrollView.auk.currentPageIndex else { return }

    if currentPageIndex >= imageDescriptions.count {
      return
    }
    
    imageDescriptions[currentPageIndex] = description
    showCurrentImageDescription()
  }
  
  private var currentImageDescription: String? {
    guard let currentPageIndex = scrollView.auk.currentPageIndex else { return nil }

    if currentPageIndex >= imageDescriptions.count {
      return nil
    }
    
    return imageDescriptions[currentPageIndex]
  }
  
  // MARK: - UIScrollViewDelegate
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    showCurrentImageDescription()
  }
}

