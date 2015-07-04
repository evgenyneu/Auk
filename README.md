🔨🔨🔨 This is work in progress 🔨🔨🔨


# Auk, an image scroll view for iOS / Swift

This is an iOS library that shows images in a scroll view with page indicator.

* Displays local and remote images.
* Remote images are automatically downloaded when they become visible in the scroll view.
* Allows to specify placeholder and error images for remote sources.
* Includes auto scrolling.

<img src='https://raw.githubusercontent.com/evgenyneu/Auk/master/Graphics/Screenshots/auk_paged_image_scroller_ios.jpg' alt='Great Auks by John Gerrard Keulemans' width='382'>

*Drawing of the great auk by John Gerrard Keulemans, circa 1900. Source: [Wikimedia Commons](https://en.wikipedia.org/wiki/Great_auk).*


## Setup

There are three ways you can add Auk to your Xcode project.

**Add source (iOS 7+)**

Simply add [MoaDistrib.swift](https://github.com/evgenyneu/moa/blob/master/Distrib/MoaDistrib.swift) and [AukDistrib.swift](https://github.com/evgenyneu/Auk/blob/master/Distrib/AukDistrib.swift) files into your Xcode project.

**Setup with Carthage (iOS 8+)**

Alternatively, add `github "evgenyneu/Auk" ~> 2.0` to your Cartfile and run `carthage update`.

**Setup with CocoaPods (iOS 8+)**

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    pod 'Auk', '~> 2.0'


#### Setup in Xcode 6

Auk is written in Swift 2 for Xcode 7. See [Swift 1.2 setup instuctions](https://github.com/evgenyneu/moa/wiki/Setup-with-Xcode-6-and-Swift-1.2) for Xcode 6 projects.


## Usage

Auk extends UIScrollView class by creating the `auk` property that you can use for showing images.

```Swift
// Show local image
scrollView.auk.show(image: UIImage(named: "bird"))

// Show remote image
scrollView.auk.show(url: "http://site.com/bird.jpg")

// Scroll to page
scrollView.auk.scrollTo(2, animated: true)

// Scroll to the next page
scrollView.auk.scrollToNextPage()

// Scroll to the previous page
scrollView.auk.scrollToPreviousPage()

// Remove all images
scrollView.auk.removeAll()

// Return the number of pages in the scroll view
scrollView.auk.numberOfPages

// Get the index of the current page
scrollView.auk.currentPageIndex

// Scroll images automatically with the interval of 3 seconds
scrollView.auk.startAutoScroll(delaySeconds: 3)

// Stop auto-scrolling of the images
scrollView.auk.stopAutoScroll()
```

## Configuration

Use the `auk.settings` property to configure behavior and appearance of the scroll view. See the [configuration manual](https://github.com/evgenyneu/Auk/wiki/Configuration) for the complete list of configuration options.

```Swift
// Make the images fill entire page
scrollView.auk.settings.contentMode = UIViewContentMode.ScaleAspectFill

// Set background color of page indicator
scrollView.auk.settings.pageControl.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.3)

// Show placeholder image while remote image is being downloaded.
scrollView.auk.settings.placeholderImage = UIImage(named: "placeholder.jpg")
```

## Credits

* The Great Auk drawing by John James Audubon, 1827-1838. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:341_Great_Auk.jpg).
* Great Auks drawing by John Gerrard Keulemans, circa 1900. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Great_auk_with_juvenile.jpg).
* The Great Auk drawing from Popular Science Monthly Volume 62, 1902-1903. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:PSM_V62_D510_The_great_auk.png).
* Great Auk egg, U. S. National Museum, in a book by Arthur Cleveland Bent, 1919. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Great_Auk_Egg_Bent.jpg).
* Only known illustration of a Great Auk frawn from life by Olaus Wormius, 1655. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Wormius%27_Great_Auk.jpg).
* The Great Auks at Home, oil on canvas by John Gerrard Keulemans. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Pinguinus.jpg).
* Alca impennis by John Gould: The Birds of Europe, vol. 5 pl. 55, 19th century. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Alca_Impennis_by_John_Gould.jpg).
* Great Auks (extinct) in summer and winter plumage by John Gerrard Keulemans, before 1912. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Keulemans-GreatAuk.jpg).



## License

Auk is released under the [MIT License](LICENSE).
