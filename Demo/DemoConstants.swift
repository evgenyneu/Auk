import UIKit

struct DemoConstants {
  static let button = DemoConstantsButton()

  static let initialImage = (
    fileName: "John_James_Audubon_Great_Auk.jpg",
    description: "The Great Auk drawing by John James Audubon, 1827-1838."
  )

  static let localImages = [
    (
      fileName: "Pinguinus.jpg",
      description: "The Great Auks at Home, oil on canvas by John Gerrard Keulemans."
    ),
    (
      fileName: "popular_science_monthly_the_great_auk.jpg",
      description: "The Great Auk drawing from Popular Science Monthly Volume 62, 1902-1903."
    )
  ]

  static let remoteImageBaseUrl = "http://evgenii.com/files/2015/06/auk_demo/"

  static let remoteImages = [
    (
      fileName: "Alca_Impennis_by_John_Gould.jpg",
      description: "Alca impennis by John Gould: The Birds of Europe, vol. 5 pl. 55, 19th century."
    ),
    (
      fileName: "Great_Auk_Egg_Bent.jpg",
      description: "Great Auk egg, U. S. National Museum, in a book by Arthur Cleveland Bent, 1919."
    ),
    (
      fileName: "Great_auk_with_juvenile.jpg",
      description: "Great auk with juvenile drawing by John Gerrard Keulemans, circa 1900."
    ),
    (
      fileName: "Keulemans-GreatAuk.jpg",
      description: "Great Auks in summer and winter plumage by John Gerrard Keulemans, before 1912."
    ),
    (
      fileName: "SimlulateNoImage.jpg",
      description: "Image download failure test."
    )
  ]
}

struct DemoConstantsButton {
  let borderWidth: CGFloat = 2
  let cornerRadius: CGFloat = 20
  let borderColor = UIColor.white
}
