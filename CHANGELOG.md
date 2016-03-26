# Auk version history

## 2.1.0 (2016-03-26)

* [eyaldar](https://github.com/eyaldar) added `updateAt` method that allows to update an existing image with a new one.
* Fixed a bug in `currentPageIndex` property that returned page indexes less than zero or greater than the largest page index.
* Property `currentPageIndex` is optional and returns nil if there are no images.
* Add new buttons to the demo app to test update of images.

## 2.0.19 (2015-11-13)

* Fixed `images` property. Now it returns both local and remote images.