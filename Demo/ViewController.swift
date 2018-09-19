import UIKit
import Auk
import moa

class ViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  
  var imageDescriptions = [String]()
  @IBOutlet weak var imageDescriptionLabel: UILabel!
  
  @IBOutlet weak var deleteButton: UIButton!
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  @IBOutlet weak var autoScrollButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.delegate = self
    scrollView.auk.settings.placeholderImage = UIImage(named: "great_auk_placeholder.png")
    scrollView.auk.settings.errorImage = UIImage(named: "error_image.png")
    
    // Preload the next and previous images
    scrollView.auk.settings.preloadRemoteImagesAround = 1
    
    // Turn on the image logger. The download log will be visible in the Xcode console
    Moa.logger = MoaConsoleLogger
    
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
  @IBAction func onShowLocalTapped(_ sender: AnyObject) {
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
  @IBAction func onShowRemoteTapped(_ sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    for remoteImage in DemoConstants.remoteImages {
      let url =  "\(DemoConstants.remoteImageBaseUrl)\(remoteImage.fileName)"
      scrollView.auk.show(url: url, accessibilityLabel: remoteImage.description)
      
      imageDescriptions.append(remoteImage.description)
    }
    
    showCurrentImageDescription()
  }
  
  // Scroll to the next image
  @IBAction func onShowRightButtonTapped(_ sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    
    if RightToLeft.isRightToLeft(view) {
      scrollView.auk.scrollToPreviousPage()
    } else {
      scrollView.auk.scrollToNextPage()
    }
  }

  // Scroll to the previous image
  @IBAction func onShowLeftButtonTapped(_ sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    
    if RightToLeft.isRightToLeft(view) {
      scrollView.auk.scrollToNextPage()
    } else {
      scrollView.auk.scrollToPreviousPage()
    }
  }

  // Remove all images
  @IBAction func onDeleteButtonTapped(_ sender: AnyObject) {
    scrollView.auk.stopAutoScroll()
    scrollView.auk.removeAll()
    imageDescriptions = []
    showCurrentImageDescription()
  }

  @IBAction func onDeleteCurrentButtonTapped(_ sender: AnyObject) {
    guard let indexToRemove = scrollView.auk.currentPageIndex else { return }
    scrollView.auk.stopAutoScroll()
    
    scrollView.auk.removeCurrentPage(animated: true)
  
    if imageDescriptions.count >= scrollView.auk.numberOfPages {
      imageDescriptions.remove(at: indexToRemove)
    }
    
    showCurrentImageDescription()
  }
  
  @IBAction func onAutoscrollTapped(_ sender: AnyObject) {
    scrollView.auk.startAutoScroll(delaySeconds: 2)
  }
  
  @IBAction func onScrollViewTapped(_ sender: AnyObject) {
    imageDescriptionLabel.text = "Tapped image #\(scrollView.auk.currentPageIndex ?? 42)"
  }
  
  // MARK: - Handle orientation change
  
  /// Animate scroll view on orientation change
  override func viewWillTransition(to size: CGSize,
                                         with coordinator: UIViewControllerTransitionCoordinator) {
    
    super.viewWillTransition(to: size, with: coordinator)
    
    guard let pageIndex = scrollView.auk.currentPageIndex else { return }
    let newScrollViewWidth = size.width // Assuming scroll view occupies 100% of the screen width
    
    coordinator.animate(alongsideTransition: { [weak self] _ in
      self?.scrollView.auk.scrollToPage(atIndex: pageIndex, pageWidth: newScrollViewWidth, animated: false)
    }, completion: nil)
  }
  
  /// Animate scroll view on orientation change
  /// Support iOS 7 and older
  override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation,
                                                 duration: TimeInterval) {
    
    super.willRotate(to: toInterfaceOrientation, duration: duration)
    
    var screenWidth = UIScreen.main.bounds.height
    if toInterfaceOrientation.isPortrait {
      screenWidth = UIScreen.main.bounds.width
    }
    
    guard let pageIndex = scrollView.auk.currentPageIndex else { return }
    scrollView.auk.scrollToPage(atIndex: pageIndex, pageWidth: screenWidth, animated: false)
  }
  
  // MARK: - Image description
  
  private func showCurrentImageDescription() {
    if let description = currentImageDescription {
      imageDescriptionLabel.text = description
    } else {
      imageDescriptionLabel.text = nil
    }
  }
  
  private func changeCurrentImageDescription(_ description: String) {
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
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    showCurrentImageDescription()
  }
}

