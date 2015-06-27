🔨🔨🔨 This is work in progress 🔨🔨🔨


# Auk, an image scroll view for iOS / Swift

This is an iOS library that shows images in a scroll view with page indicator.

<img src='https://raw.githubusercontent.com/evgenyneu/Auk/master/Graphics/Drawings/Great_auk_with_juvenile.jpg' width='400'>

*This library is dedicated to the great auk, a flightless bird that became extinct in the mid-19th century.*
Source: [Wikipedia](https://en.wikipedia.org/wiki/Great_auk).

## Usage

Auk extends UIScrollView class by creating the `auk` property that you can use for showing images.

```Swift
// Show local image
scrollView.auk.show(image: UIImage(named: "bird"))

// Show remote image
scrollView.auk.show(url: "http://site.com/bird.jpg")

// Scroll images automatically with the interval of 3 seconds
scrollView.auk.autoScroll(timeout: 3)

// Stop auto-scrolling of the images
scrollView.auk.stopAutoScroll()

// Scroll to the image with index 2
scrollView.auk.scrollTo(image: 2, animated: true)

// Remove image with index 2
scrollView.auk.remove(image: 2)

// Remove all images
scrollView.auk.removeAll()
```


## Credits

* The Great Auk drawing by John James Audubon, 1827-1838. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:341_Great_Auk.jpg).

* The Great Auk drawing by John Gerrard Keulemans, circa 1900. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Great_auk_with_juvenile.jpg).

* The Great Auk drawing from Popular Science Monthly Volume 62, 1902-1903. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:PSM_V62_D510_The_great_auk.png).

* Great Auk egg, U. S. National Museum, in a book by Arthur Cleveland Bent, 1919. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Great_Auk_Egg_Bent.jpg).

* Only known illustration of a Great Auk frawn from life by Olaus Wormius, 1655. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Wormius%27_Great_Auk.jpg).

* The Great Auks at Home, oil on canvas by John Gerrard Keulemans. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Pinguinus.jpg).

* Alca impennis by John Gould: The Birds of Europe, vol. 5 pl. 55, 19th century. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Alca_Impennis_by_John_Gould.jpg).

* Great Auks (extinct) in summer and winter plumage by John Gerrard Keulemans, before 1912. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Keulemans-GreatAuk.jpg).



## License

Auk is released under the [MIT License](LICENSE).
