import XCTest
import moa
@testable import Auk

class AukInterfaceUpdateRemoteImageTests: XCTestCase {
  var scrollView: UIScrollView!
  var auk: Auk!
  
  override func setUp() {
    super.setUp()
    
    scrollView = UIScrollView()
    
    // Set scroll view size
    let size = CGSize(width: 120, height: 90)
    scrollView.bounds = CGRect(origin: CGPoint(), size: size)
    
    auk = Auk(scrollView: scrollView)
  }
  
  override func tearDown() {
    super.tearDown()
    
    MoaSimulator.clear()
  }
  
  func testUpdateRemoteImage_overLocalImage() {
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    let simulator = MoaSimulator.simulate("auk.png")
    
    auk.updateAt(0, url: "http://site.com/auk.png")
    
    XCTAssertEqual(1, simulator.downloaders.count)
    XCTAssertEqual("http://site.com/auk.png", simulator.downloaders.first!.url)
    
    let image67px = uiImageFromFile("67px.png")
    simulator.respondWithImage(image67px)
    
    XCTAssertEqual(1, aukPages(scrollView).count)
    
    // Loads image
    XCTAssertEqual(67, firstAukImage(scrollView, pageIndex: 0)!.size.width)
  }
  
  func testUpdateRemoteImage_overRemoteImage() {
    let simulator = MoaSimulator.simulate(".png")
    auk.show(url: "http://site.com/auk.png")
    
    auk.updateAt(0, url: "http://site.com/moa.png")
    
    XCTAssertEqual(2, simulator.downloaders.count)
    
    // Cancels the previous download
    XCTAssertEqual("http://site.com/auk.png", simulator.downloaders.first!.url)
    XCTAssert(simulator.downloaders.first!.cancelled)

    // Downloads the new one
    XCTAssertEqual("http://site.com/moa.png", simulator.downloaders.last!.url)

    let image67px = uiImageFromFile("67px.png")
    simulator.respondWithImage(image67px)

    XCTAssertEqual(1, aukPages(scrollView).count)

    // Loads image
    XCTAssertEqual(67, firstAukImage(scrollView, pageIndex: 0)!.size.width)
  }
  
  func testUpdateRemoteImage_indexLargerThanExist() {
    let simulator = MoaSimulator.simulate(".png")
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    auk.updateAt(1, url: "http://site.com/moa.png")
    
    XCTAssertEqual(0, simulator.downloaders.count)
    XCTAssertEqual(96, firstAukImage(scrollView, pageIndex: 0)!.size.width)
  }
  
  func testUpdateRemoteImage_indexNegative() {
    let simulator = MoaSimulator.simulate(".png")
    
    let image = uiImageFromFile("96px.png")
    auk.show(image: image)
    
    auk.updateAt(-1, url: "http://site.com/moa.png")
    
    XCTAssertEqual(0, simulator.downloaders.count)
    XCTAssertEqual(96, firstAukImage(scrollView, pageIndex: 0)!.size.width)
  }
  
  func testUpdateRemoteImage_noImagesToUpdate() {
    let simulator = MoaSimulator.simulate(".png")
    
    auk.updateAt(-1, url: "http://site.com/moa.png")
    
    XCTAssertEqual(0, simulator.downloaders.count)
    XCTAssertEqual(0, aukPages(scrollView).count)
  }
  
  // MARK: - Accessibility
  
  func testUpdateAccessiblePageView_withLabel() {
    let _ = MoaSimulator.simulate(".png")
    let image = uiImageFromFile("96px.png")
    auk.show(image: image, accessibilityLabel: "Penguin")
    
    auk.updateAt(0, url: "http://site.com/auk.png",
                 accessibilityLabel: "White knight riding a wooden horse on wheels.")

    let page = aukPage(scrollView, pageIndex: 0)!
    
    XCTAssert(page.isAccessibilityElement)
    XCTAssertEqual(page.accessibilityTraits, UIAccessibilityTraitImage)
    XCTAssertEqual("White knight riding a wooden horse on wheels.", page.accessibilityLabel!)
  }
  
  func testUpdateAccessiblePageView_removeExistingLabel() {
    let _ = MoaSimulator.simulate(".png")
    let image = uiImageFromFile("96px.png")
    auk.show(image: image, accessibilityLabel: "Penguin")
    
    auk.updateAt(0, url: "http://site.com/auk.png")
    
    let page = aukPage(scrollView, pageIndex: 0)!
    
    XCTAssert(page.isAccessibilityElement)
    XCTAssertEqual(page.accessibilityTraits, UIAccessibilityTraitImage)
    XCTAssert(page.accessibilityLabel == nil)
  }
}
