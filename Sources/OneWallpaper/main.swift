//
//  main.swift
//  OneWallpaper
//
//  Created by Liyun Xiu on 10/4/20.
//

import Foundation
import Wallpaper
import ArgumentParser

struct OneWallpaper: ParsableCommand {
    // Customize your command's help and subcommands by implementing the
    // `configuration` property.
    static var configuration = CommandConfiguration(
        // Optional abstracts and discussions are used for help output.
        abstract: "A tool to split your wallpaper and setup them across multiple monitors",

        // Commands can define a version for automatic '--version' support.
        version: "1.0.0"
        )
    
    @Argument(help: "Set image path or directory path to set random image from directory")
    var wallpaper: String
    
    @Flag(help: "true to set the same wallpaper in each monitor, otherwise set wallpaper across monitors to they look like one image")
    var duplicate = false
    
    mutating func run() {
        let wp = Wallpaper()
        var isDir : ObjCBool = false
        guard FileManager.default.fileExists(atPath: wallpaper, isDirectory: &isDir) else {
            print("File: \(wallpaper) does not exist!")
            return
        }
        
        if isDir.boolValue {
            let ph = PathHelper()
            do {
                wallpaper = try ph.getRandomImage(from: wallpaper)
            } catch {
                print(error)
                return
            }
        }

        let method = duplicate ? SetWallpaperMethod.duplicate : SetWallpaperMethod.across
        let result = wp.setWallpaper(with: wallpaper, by: method)
        switch result {
        case .success:
            print("Done!")
        case .failure(let error):
            switch error {
            case .fileNotExist:
                print("File: \(wallpaper) does not exist!")
            case .saveTemporaryImageFileFail:
                print("Cannot save temparory file!")
            case .setWallpaperFail:
                print("Set wallpaper failed!")
            case .unknown:
                print("Unknown error happened!")
            }
        }
    }
}

OneWallpaper.main()
