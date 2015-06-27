import UIKit

struct DemoConstants {
  static let button = DemoConstantsButton()
  
  static let localImageNames = [
    "John_James_Audubon_Great_Auk.jpg",
    "Pinguinus.jpg",
    "popular_science_monthly_the_great_auk.jpg",
    "Wormius_Great_Auk.jpg"
  ]
  
  static let remoteImageBaseUrl = "http://evgenii.com/files/2015/06/auk_demo/"
  
  static let remoteImageNames = [
    "Alca_Impennis_by_John_Gould.jpg",
    "Great_Auk_Egg_Bent.jpg",
    "Great_auk_with_juvenile.jpg",
    "Keulemans-GreatAuk.jpg"
  ]
}

struct DemoConstantsButton {
  let borderWidth: CGFloat = 2
  let cornerRadius: CGFloat = 20
  let borderColor = UIColor.whiteColor()
}