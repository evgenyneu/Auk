import UIKit
import Auk
import moa

class ViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.auk.settings.placeholderImage = UIImage(named: "great_auk_placeholder.png")
    scrollView.auk.settings.errorImage = UIImage(named: "error_image.png")
    loadFirstImage()
  }
  
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
      
    let pageIndex = scrollView.auk.currentPageIndex
    
    coordinator.animateAlongsideTransition({ [weak self] _ in
      self?.scrollView.auk.changePage(pageIndex, pageWidth: size.width, animated: false)
    }, completion: nil)
  }
  
  func loadFirstImage() {
    if let image = UIImage(named: DemoConstants.firstImageName) {
      scrollView.auk.show(image: image)
    }
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
    var pageIndex = scrollView.auk.currentPageIndex + 1
    if pageIndex >= scrollView.auk.numberOfPages { pageIndex = 0 }

    changePage(pageIndex)
  }
  
  @IBAction func onPreviousPageTapped(sender: AnyObject) {
    var pageIndex = scrollView.auk.currentPageIndex - 1
    if pageIndex < 0 { pageIndex =  scrollView.auk.numberOfPages - 1 }
    
    changePage(pageIndex)
  }
  
  private func changePage(pageIndex: Int) {
    scrollView.auk.changePage(pageIndex, animated: true)
  }
  
  @IBAction func onDeleteButtonTapped(sender: AnyObject) {
    scrollView.auk.removeAll()
  }
}

