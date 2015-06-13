🔨🔨🔨 This is work in progress 🔨🔨🔨


# Great auk, a paged image scroll view for iOS / Swift

This is an iOS library that shows remote and local images in a scroll view with paging indicator.

<img src='https://raw.githubusercontent.com/evgenyneu/GreatAuk/master/Graphics/Drawings/Great_auk_with_juvenile.jpg' width='400'>

*The great auk was a flightless bird that became extinct in the mid-19th century.*
Source: [Wikipedia](https://en.wikipedia.org/wiki/Great_auk).

## Usage

Great auk is an extension of UIScrollView class that creates a `greatAuk` property that you can use for showing images.

```Swift
// Show local image
scrollView.greatAuk.show(image: UIImage(named: "bird.png"))

// Show remote image
scrollView.greatAuk.show(url: "http://site.com/bird.jpg")

// Scroll images automatically with the interval of 3 seconds
scrollView.greatAuk.autoScroll(timeout: 3)

// Stop auto-scrolling of the images.
scrollView.greatAuk.stopAutoScroll()

// Scroll to the image with index 2.
scrollView.greatAuk.scrollTo(image: 2, animated: true)

// Remove image with index 2
scrollView.greatAuk.remove(image: 2)

// Remove all images
scrollView.greatAuk.removeAll()
```


## Credits

* Great Auk drawing by John James Audubon, 1827-1838. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:341_Great_Auk.jpg).
* Great Auks drawing by John Gerrard Keulemans, circa 1900. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Great_auk_with_juvenile.jpg).
