# Auk version history


## 11.0 (2019-10-27)

* Updated `moa` image loader to support images with `application/octet-stream` MIME type in iOS 13 (see [iOS 13 Release Notes](https://developer.apple.com/documentation/ios_ipados_release_notes/ios_13_release_notes)).


## 10.0 (2019-04-20)

* Update to Swift 5.0.


## 9.0 (2018-09-19)

* Update to Swift 4.2.


## 8.0 (2017-09-23)

* Update to Swift 4.0.


## 7.0 (2016-09-09)

* Update to Xcode 8 GM version of Swift.


## 6.0 (2016-08-27)

* Update to Xcode 8 Beta 6 version of Swift.


## 5.0 (2016-08-13)

* Update to Xcode 8 Beta 5 version of Swift.


## 4.0 (2016-07-07)

* Update to Xcode 8 Beta 2 version of Swift.

* [Valpertui](https://github.com/Valpertui) added `removePage` and `removeCurrentPage` methods.

* API change: method `scrollTo(2, animated: true)` was renamed to `scrollToPage(atIndex: 2, animated: true)`.

* API change: method `updateAt(0, url: "https://bit.ly/auk_image")` was renamed to `updatePage(atIndex: 0, url: "https://bit.ly/auk_image")`.

* API change: method `updateAt(1, image: image)` was renamed to `updatePage(atIndex: 1, image: image)`.


## 3.0 (2016-06-17)

* Update to Swift 3.0


## 2.1.5 (2016-06-01)

* Added support for loading remote images in GIF format and files with non-standard mime-type *image/jpg*.


## 2.1.4 (2016-04-29)

* Added `settings.preloadRemoteImagesAround` property that controls the loading of remote images.


## 2.1.3 (2016-03-30)

* Fixed the crash occured when the scroll view had zero bounds width.


## 2.1.2 (2016-03-27)

* When updating an image with a remote image the current image is replaced only after the new image has finished downloading. This creates a smoother transition from the current image to the new image.


## 2.1.1 (2016-03-26)

* Fixed: fade-in animation was not used when showing remote images without placeholders.


## 2.1.0 (2016-03-26)

* [eyaldar](https://github.com/eyaldar) added `updateAt` method that allows to update an existing image with a new one.
* Fixed a bug in `currentPageIndex` property that returned page indexes less than zero or greater than the largest page index.
* Property `currentPageIndex` is optional and returns nil if there are no images.
* Add new buttons to the demo app to test update of images.


## 2.0.19 (2015-11-13)

* Fixed `images` property. Now it returns both local and remote images.