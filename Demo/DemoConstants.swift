import UIKit

struct DemoConstants {
  static let button = DemoConstantsButton()
  
  static let localImageNames = [
    "John_James_Audubon_Great_Auk.jpg",
    "Pinguinus.jpg",
    "popular_science_monthly_the_great_auk.jpg",
    "Wormius_Great_Auk.jpg"
  ]
}

struct DemoConstantsButton {
  let borderWidth: CGFloat = 2
  let cornerRadius: CGFloat = 20
  let borderColor = UIColor.whiteColor()
}