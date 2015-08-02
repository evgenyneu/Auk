import UIKit
import XCTest
@testable import Auk

class UIScrollViewAukExtensionTests: XCTestCase {
  func testGetCreatesAndStoresMoaInstance() {
    let scrollView = UIScrollView()
    let auk1 = scrollView.auk
    let auk2 = scrollView.auk
    
    XCTAssert(auk1 === auk2)
  }
  
  func testSet() {
    let scrollView = UIScrollView()
    let auk = Auk(scrollView: scrollView)
    scrollView.auk = auk
    
    XCTAssert(scrollView.auk === auk)
  }
}