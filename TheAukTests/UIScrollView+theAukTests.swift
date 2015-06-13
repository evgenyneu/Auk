import UIKit
import XCTest

class UIScrollViewMoaExtensionTests: XCTestCase {
  func testGetCreatesAndStoresMoaInstance() {
    let scrollView = UIScrollView()
    let theAuk1 = scrollView.theAuk
    let theAuk2 = scrollView.theAuk
    
    XCTAssert(theAuk1 === theAuk2)
  }
  
  func testSet() {
    let scrollView = UIScrollView()
    let theAuk = TheAuk()
    scrollView.theAuk = theAuk
    
    XCTAssert(scrollView.theAuk === theAuk)
  }
}