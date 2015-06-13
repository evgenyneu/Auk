🔨🔨🔨 This is work in progress 🔨🔨🔨


# The Great Auk, a paged image scroll view for iOS / Swift

This is an iOS library that shows remote and local images in a scroll view with paging indicator.

<img src='https://raw.githubusercontent.com/evgenyneu/GreatAuk/master/Graphics/Drawings/Great_auk_with_juvenile.jpg' width='400'>

*The great auk was a flightless bird that became extinct in the mid-19th century.*
Source: [Wikipedia](https://en.wikipedia.org/wiki/Great_auk).

## Usage

The Great Auk extends UIScrollView class by creating `theGreatAuk` property that you can use for showing images.

```Swift
// Show local image
scrollView.theGreatAuk.show(image: UIImage(named: "bird"))

// Show remote image
scrollView.theGreatAuk.show(url: "http://site.com/bird.jpg")

// Scroll images automatically with the interval of 3 seconds
scrollView.theGreatAuk.autoScroll(timeout: 3)

// Stop auto-scrolling of the images
scrollView.theGreatAuk.stopAutoScroll()

// Scroll to the image with index 2
scrollView.theGreatAuk.scrollTo(image: 2, animated: true)

// Remove image with index 2
scrollView.theGreatAuk.remove(image: 2)

// Remove all images
scrollView.theGreatAuk.removeAll()
```


## Credits

* Great Auks drawing by John James Audubon, 1827-1838. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:341_Great_Auk.jpg).
* Great Auks drawing by John Gerrard Keulemans, circa 1900. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Great_auk_with_juvenile.jpg).


## License

The Great Auk is released under the [MIT License](LICENSE).
