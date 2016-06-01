# Auk version history

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