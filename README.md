🔨🔨🔨 This is work in progress 🔨🔨🔨


# The Auk, a paged image scroll view for iOS / Swift

This is an iOS library that shows remote and local images in a scroll view with paging indicator.

<img src='https://raw.githubusercontent.com/evgenyneu/TheAuk/master/Graphics/Drawings/Great_auk_with_juvenile.jpg' width='400'>

*The great auk was a flightless bird that became extinct in the mid-19th century.*
Source: [Wikipedia](https://en.wikipedia.org/wiki/Great_auk).

## Usage

The Auk extends UIScrollView class by creating `theAuk` property that you can use for showing images.

```Swift
// Show local image
scrollView.theAuk.show(image: UIImage(named: "bird"))

// Show remote image
scrollView.theAuk.show(url: "http://site.com/bird.jpg")

// Scroll images automatically with the interval of 3 seconds
scrollView.theAuk.autoScroll(timeout: 3)

// Stop auto-scrolling of the images
scrollView.theAuk.stopAutoScroll()

// Scroll to the image with index 2
scrollView.theAuk.scrollTo(image: 2, animated: true)

// Remove image with index 2
scrollView.theAuk.remove(image: 2)

// Remove all images
scrollView.theAuk.removeAll()
```


## Credits

* Great Auks drawing by John James Audubon, 1827-1838. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:341_Great_Auk.jpg).
* Great Auks drawing by John Gerrard Keulemans, circa 1900. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Great_auk_with_juvenile.jpg).


## License

The Auk is released under the [MIT License](LICENSE).
