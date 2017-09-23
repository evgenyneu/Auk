# Auk, an image slideshow for iOS / Swift

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/Auk.svg?style=flat)](http://cocoadocs.org/docsets/Auk)
[![License](https://img.shields.io/cocoapods/l/Auk.svg?style=flat)](LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/Auk.svg?style=flat)](http://cocoadocs.org/docsets/Auk)

This is an iOS library that shows an image carousel with a page indicator. Users can scroll through local and remote images or watch them scroll automatically.

```Swift
  scrollView.auk.show(url: "https://bit.ly/auk_image")
  scrollView.auk.show(url: "https://bit.ly/moa_image")

  if let image = UIImage(named: "local_bird.jpg") {
    scrollView.auk.show(image: image)
  }
```

* Uses Auto Layout and supports animated transition during screen orientation change.
* Allows to specify placeholder and error images for remote sources.
* Includes caching and logging for remote images.
* Supports right-to-left languages.
* Allows to specify accessiblity labels for the images.
* Includes ability to simulate and verify image download in unit tests.


<img src='https://raw.githubusercontent.com/evgenyneu/Auk/master/Graphics/Screenshots/auk_paged_image_scroller_ios.jpg' alt='Great Auks by John Gerrard Keulemans' width='382'>

*Drawing of the great auk by John Gerrard Keulemans, circa 1900. Source: [Wikimedia Commons](https://en.wikipedia.org/wiki/Great_auk).*



## Setup

There are three ways you can add Auk to your Xcode project.

#### Add source (iOS 7+)

Simply add two files to your project:

1. Moa image downloader [MoaDistrib.swift](https://github.com/evgenyneu/moa/blob/master/Distrib/MoaDistrib.swift).
2. Auk image slideshow [AukDistrib.swift](https://github.com/evgenyneu/Auk/blob/master/Distrib/AukDistrib.swift).

#### Setup with Carthage (iOS 8+)

1. Add `github "evgenyneu/Auk" ~> 8.0` to your Cartfile.
2. Run `carthage update`.
3. Add `moa` and `Auk` frameworks into your project.

#### Setup with CocoaPods (iOS 8+)

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    target 'Your target name'
    pod 'moa', '~> 9.0'
    pod 'Auk', '~> 8.0'


### Legacy Swift versions

Setup a [previous version](https://github.com/evgenyneu/Auk/wiki/Legacy-Swift-versions) of the library if you use an older version of Swift.



## Usage

1. Add `import Auk` to your source code if you used Carthage or CocoaPods setup methods.
1. Add a scroll view to the storyboard and create an outlet property `scrollView` in your view controller.
1. Clear the **Adjust Scroll View Insets** checkbox in the *Attribute Inspector* of your view controller.

<img src='https://raw.githubusercontent.com/evgenyneu/Auk/master/Graphics/Screenshots/adjust_table_view_insets.png' width='463' alt='Clear "Adjust Scroll View Insets" in your View Controller.'>

Auk extends UIScrollView class by creating the `auk` property.

```Swift
// Show remote images
scrollView.auk.show(url: "https://bit.ly/auk_image")
scrollView.auk.show(url: "https://bit.ly/moa_image")

// Show local image
if let image = UIImage(named: "bird.jpg") {
  scrollView.auk.show(image: image)
}

// Return the number of pages in the scroll view
scrollView.auk.numberOfPages

// Get the index of the current page or nil if there are no pages
scrollView.auk.currentPageIndex

// Return currently displayed images
scrollView.auk.images
```

#### Scrolling from code

```Swift
// Scroll to page
scrollView.auk.scrollToPage(atIndex: 2, animated: true)

// Scroll to the next page
scrollView.auk.scrollToNextPage()

// Scroll to the previous page
scrollView.auk.scrollToPreviousPage()
```

#### Auto scrolling

```Swift
// Scroll images automatically with the interval of 3 seconds
scrollView.auk.startAutoScroll(delaySeconds: 3)

// Stop auto-scrolling of the images
scrollView.auk.stopAutoScroll()
```

Note that auto scrolling stops when the user starts scrolling manually.

#### Accessibility

One can pass an image description when calling the `show` methods. This description will be spoken by the device in accessibility mode for the current image on screen.

```Swift
// Supply accessibility label for the image
scrollView.auk.show(url: "https://bit.ly/auk_image", accessibilityLabel: "Picture of a great auk.")
```

#### Removing pages

```Swift
// Remove a page at given index
scrollView.auk.removePage(atIndex: 0, animated: true, completion: {})

// Remove the currently shown page
scrollView.auk.removeCurrentPage(animated: true, completion: {})

// Remove all pages
scrollView.auk.removeAll()
```


#### Updating pages

One can change existing image by calling `updateAt` methods and supplying the page index.

```Swift
// Replace the image on a given page with a remote image.
// The current image is replaced after the new image has finished downloading.
scrollView.auk.updatePage(atIndex: 0, url: "https://bit.ly/moa_image")

// Replace the image on a given page with a local image.
if let image = UIImage(named: "bird.jpg") {
  scrollView.auk.updatePage(atIndex: 1, image: image)
}
```


## Loading images from insecure HTTP hosts

If your remote image URLs are not *https* you will need to [add an exception](http://evgenii.com/blog/loading-data-from-non-secure-hosts-in-ios9-with-nsurlsession/) to the **Info.plist** file. This will allow the App Transport Security to load the images from insecure HTTP hosts.

## Configuration

Use the `auk.settings` property to configure behavior and appearance of the scroll view **before showing the images**. See the [configuration manual](https://github.com/evgenyneu/Auk/wiki/Auk-configuration) for the complete list of configuration options.

```Swift
// Make the images fill entire page
scrollView.auk.settings.contentMode = .scaleAspectFill

// Set background color of page indicator
scrollView.auk.settings.pageControl.backgroundColor = UIColor.gray.withAlphaComponent(0.3)

// Show placeholder image while remote image is being downloaded.
scrollView.auk.settings.placeholderImage = UIImage(named: "placeholder.jpg")

// Show an image AFTER specifying the settings
scrollView.auk.show(url: "https://bit.ly/auk_image")
```

## Preloading remote images

By default remote images are loaded after they become visible to user. One can ask the library to preload remote images  by setting the property `preloadRemoteImagesAround`.

```Swift
// Set the property before showing remote images
scrollView.auk.settings.preloadRemoteImagesAround = 1

// Add remote images. The first two images will start loading simultaneously.
scrollView.auk.show(url: "https://bit.ly/auk_image")
scrollView.auk.show(url: "https://bit.ly/moa_image")

// The third image will start loading when the user scrolls to the second page.
scrollView.auk.show(url: "https://bit.ly/auks_at_home")
```

The `preloadRemoteImagesAround` property defines the number of remote images to preload around the current page. For example, if `preloadRemoteImagesAround = 2` and we are viewing the first page it will preload images on the second and third pages. If we are viewing 5th page then it will preload images on pages 3, 4, 6 and 7 (unless they are already loaded). The default value is 0.

Note that images are loaded all at the same time, therefore, using large values for `preloadRemoteImagesAround` may result in the first image being delayed on slow networks because the limited bandwidth will be shared by many image downloads.

## Size change animation

Read [size animation](https://github.com/evgenyneu/Auk/wiki/Size-animation) manual if you need to animate the scroll view during device orientation change.


## Image caching

Auk uses [moa image downloader](https://github.com/evgenyneu/moa) for getting remote images. You can configure its caching settings by changing the `Moa.settings.cache.requestCachePolicy` property. Add `import moa` to your source code if you used Carthage or CocoaPods setup methods.


```Swift
import moa // for Carthage and CocoaPods

// ...

// By default images are cached according to their response HTTP headers.
Moa.settings.cache.requestCachePolicy = .useProtocolCachePolicy

// Use local cache regardless of response HTTP headers.
Moa.settings.cache.requestCachePolicy = .returnCacheDataElseLoad
```

Note: [moa image downloader](https://github.com/evgenyneu/moa) offers other features including request logging and HTTP settings.

## Logging

If you want to know when the remote images are being loaded you can log the network activity to console, as shown in the following example. Please refer to the [moa logging manual](https://github.com/evgenyneu/moa/wiki/Logging-with-Moa) for more information.

```Swift
import moa // for Carthage and CocoaPods

// ...

// Log to console
Moa.logger = MoaConsoleLogger

// Show an existing image
scrollView.auk.show(url: "https://bit.ly/auk_image")

// Attempt to show a missing image
scrollView.auk.show(url: "https://bit.ly/missing_auk.jpg")
```

<img src='https://raw.githubusercontent.com/evgenyneu/Auk/master/Graphics/Screenshots/auk_swift_slideshow_logging_console_2.png' alt='Log Auk remove image download to console' width='506'>

## Remote image unit testing

One can simulate and verify remote image download in your unit tests. Please refer to the [moa unit testing manual](https://github.com/evgenyneu/moa/wiki/Unit-testing-with-Moa) for more information. Add `import moa` to your source code if you used Carthage or CocoaPods setup methods.


```Swift
// Autorespond with the given image
MoaSimulator.autorespondWithImage("www.site.com", image: UIImage(named: "35px.jpg")!)
```

## Respond to image tap

Here is what you need to do to add an image tap handler to the scroll view.

1. In the Storyboard drag a *Tap Gesture Recognizer* into your scroll view.
1. Show assistant editor with your view controller code.
1. Do the control-drag from the tap gesture recognizer in the storyboard into your view controller code.
1. A dialog will appear, change the *Connection* to *action* and enter the name of the method.
1. This method will be called when the scroll view is tapped. Use the `auk.currentPageIndex` property of your scroll view to get the index of the current page.

## Detect page scrolling

You can run some code when the scroll view is being scrolled by using `UIScrollViewDelegate`. See the [detect page scrolling manual](https://github.com/evgenyneu/Auk/wiki/Detect-page-scrolling) for details.

## Using Auk from Objective-C

[This manual](https://github.com/evgenyneu/Auk/wiki/Using-Auk-in-Objective-C-project) describes how to use Auk in Objective-C apps.


## Common problems

### Page control is not visible

Make sure the scrollView is added to the view tree *before* you call the `show` method. Otherwise the page control will not be created. Quick check:

```Swift
print(scrollView.superview) // should not be `nil`
scrollView.auk.show(url: "https://bit.ly/auk_image")
```

The page control is added to the superview of the scroll view when the `show` method is called. That's why page control is not created when the scroll view has no superview.

If `scrollView.superview` is `nil` then you may need to move that code that shows the images to the `viewDidAppear` method.

### Remote images are not loading

One can [turn on the logger](#logging) to see the network activity in the Xcode console and find the problem with image download.

### Page control is not changing / second remote image is not shown

If you are assigning the scroll view delegate please make sure it is done **before** showing the images.

```Swift
// Assign the delegate BEFORE showing the images
scrollView.delegate = self

scrollView.auk.show(url: "https://bit.ly/auk_image")
scrollView.auk.show(url: "https://bit.ly/moa_image")
```


## Demo app

The project includes a demo iOS app.

<img src='https://raw.githubusercontent.com/evgenyneu/Auk/master/Graphics/Screenshots/auk_demo_ios_app_2.jpg' width='414' alt='Auk pages scroll view demo iOS app'>


## Alternative solutions

Here is a list of other image slideshow libraries for iOS.


* [kimar/KIImagePager](https://github.com/kimar/KIImagePager)
* [kirualex/KASlideShow](https://github.com/kirualex/KASlideShow)
* [nicklockwood/iCarousel](https://github.com/nicklockwood/iCarousel)
* [nicklockwood/SwipeView](https://github.com/nicklockwood/SwipeView)
* [paritsohraval100/PJR-ScrollView-Slider](https://github.com/paritsohraval100/PJR-ScrollView-Slider)
* [zvonicek/ImageSlideshow](https://github.com/zvonicek/ImageSlideshow)


## Thanks 👍

* [eyaldar](https://github.com/eyaldar) added `updatePage` method.
* [Valpertui](https://github.com/Valpertui) added `removePage` and `removeCurrentPage` methods.

## Image credits

* The Great Auk drawing by John James Audubon, 1827-1838. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:341_Great_Auk.jpg).
* Great auk with juvenile drawing by John Gerrard Keulemans, circa 1900. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Great_auk_with_juvenile.jpg).
* The Great Auk drawing from Popular Science Monthly Volume 62, 1902-1903. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:PSM_V62_D510_The_great_auk.png).
* Great Auk egg, U. S. National Museum, in a book by Arthur Cleveland Bent, 1919. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Great_Auk_Egg_Bent.jpg).
* Only known illustration of a Great Auk frawn from life by Olaus Wormius, 1655. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Wormius%27_Great_Auk.jpg).
* The Great Auks at Home, oil on canvas by John Gerrard Keulemans. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Pinguinus.jpg).
* Alca impennis by John Gould: The Birds of Europe, vol. 5 pl. 55, 19th century. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Alca_Impennis_by_John_Gould.jpg).
* Great Auks in summer and winter plumage by John Gerrard Keulemans, before 1912. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Keulemans-GreatAuk.jpg).


## License

Auk is released under the [MIT License](LICENSE).

## Feedback is welcome

If you notice any issue, got stuck or just want to chat feel free to create an issue. I will be happy to help you.

## •ᴥ•

This code is dedicated to the [great auk](https://en.wikipedia.org/wiki/Great_auk), a flightless bird that became extinct in the mid-19th century.
