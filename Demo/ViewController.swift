import UIKit
import Auk
import moa

class ViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  
  @IBOutlet weak var contentScrollView: UIScrollView!
  
  var imageDescriptions = [String]()
  @IBOutlet weak var imageDescriptionLabel: UILabel!
  
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  @IBOutlet weak var autoScrollButton: UIButton!

  @IBOutlet weak var updateWithLocalButton: UIButton!
  @IBOutlet weak var updateWithRemoteButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Scrollable.createContentView(contentScrollView)
        
    layoutButtons()
    
    scrollView.delegate = self
    scrollView.auk.settings.placeholderImage = UIImage(named: "great_auk_placeholder.png")
    scrollView.auk.settings.errorImage = UIImage(named: "error_image.png")

    showInitialImage()
    showCurrentImageDescription()
    showOrHideUpdateButtons()
    showOrHideScrollingButtons()
    
    updateWithLocalButton.layer.cornerRadius = 10
    updateWithRemoteButton.layer.cornerRadius = 10
  }
  
  private func layoutButtons() {
    layoutButtons(leftButton, secondView: autoScrollButton)
    layoutButtons(autoScrollButton, secondView: rightButton)
  }
  
  private func showOrHideScrollingButtons() {
    leftButton.hidden = scrollView.auk.numberOfPages == 0
    rightButton.hidden = scrollView.auk.numberOfPages == 0
    autoScrollButton.hidden = scrollView.auk.numberOfPages == 0
  }
  
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

  @IBAction func onShowLocalTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    for localImage in DemoConstants.localImages {
      if let image = UIImage(named: localImage.fileName) {
        scrollView.auk.show(image: image, accessibilityLabel: localImage.description)
        imageDescriptions.append(localImage.description)
      }
    }
    
    showCurrentImageDescription()
    showOrHideUpdateButtons()
    showOrHideScrollingButtons()
  }

  @IBAction func onShowRemoteTapped(sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    for remoteImage in DemoConstants.remoteImages {
      let url = remoteImageUrl(remoteImage.fileName)
      scrollView.auk.show(url: url, accessibilityLabel: remoteImage.description)
      
      imageDescriptions.append(remoteImage.description)
    }
    
    showCurrentImageDescription()
    showOrHideUpdateButtons()
    showOrHideScrollingButtons()
  }
  
  private func remoteImageUrl(fileName: String) -> String {
    return "\(DemoConstants.remoteImageBaseUrl)\(fileName)"
  }
  
  @IBAction func didTapUpdateCurrentImageLocal(sender: AnyObject) {
    guard let localImage = DemoConstants.localImages.last else { return }
    guard let image = UIImage(named: localImage.fileName) else { return }
    guard let currentPageIndex = scrollView.auk.currentPageIndex else { return }
    
    scrollView.auk.updateAt(currentPageIndex, image: image)
    changeCurrentImageDescription(localImage.description)
  }

  @IBAction func didTapUpdateCurrentImageRemote(sender: AnyObject) {
    guard let remoteImage = DemoConstants.remoteImages.first else { return }
    guard let currentPageIndex = scrollView.auk.currentPageIndex else { return }

    let url = remoteImageUrl(remoteImage.fileName)
    scrollView.auk.updateAt(currentPageIndex, url: url)
    changeCurrentImageDescription(remoteImage.description)
  }
  
  private func showOrHideUpdateButtons() {
    updateWithLocalButton.hidden = scrollView.auk.numberOfPages == 0
    updateWithRemoteButton.hidden = scrollView.auk.numberOfPages == 0
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
    showCurrentImageDescription()
    showOrHideUpdateButtons()
    showOrHideScrollingButtons()
  }

  @IBAction func onAutoscrollTapped(sender: AnyObject) {
    scrollView.auk.startAutoScroll(delaySeconds: 2)
  }
  
  @IBAction func onScrollViewTapped(sender: AnyObject) {
    imageDescriptionLabel.text = "Tapped image #\(scrollView.auk.currentPageIndex)"
  }

  private func showInitialImage() {
    if let image = UIImage(named: DemoConstants.initialImage.fileName) {
      scrollView.auk.show(image: image,
        accessibilityLabel: DemoConstants.initialImage.description)
      
      imageDescriptions.append(DemoConstants.initialImage.description)
    }
  }
  
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

