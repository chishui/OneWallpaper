OneWallpaper
==============================
![alt text](logo.png "title" )

OneWallpaper is a MacOS command line tool which can help you set up a continous wallpaper across multiple monitors with one image with smooth transition.

# Install
## Build from source code
```bash
$ git clone https://github.com/chishui/OneWallpaper.git
$ cd OneWallpaper
$ make build
$ make install
```
## Install from brew
This package hasn't been published to brew. But you can still utilize brew to help you install the tool.
```bash
$ brew tap chishui/OneWallpaper
$ brew install --build-from-source onewallpaper
```

# How to Run?
## Set wallpaper with a specific image
```bash
$ one-wallpaper "/Users/me/spider-man.png" # with image file path
```
## Set wallpaper with random image from a folder
```bash
$ one-wallpaper "/Users/me/wallpaper" # with image folder
```
## Set automatic wallpaper change
You can set up a cronjob with command above to enable auto wallpaper change.
