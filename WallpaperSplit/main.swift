//
//  main.swift
//  WallpaperSplit
//
//  Created by Liyun Xiu on 10/4/20.
//

import Foundation

import ArgumentParser

struct WallpaperSplit: ParsableCommand {
    // Customize your command's help and subcommands by implementing the
    // `configuration` property.
    static var configuration = CommandConfiguration(
        // Optional abstracts and discussions are used for help output.
        abstract: "A tool to split your wallpaper and setup them across multiple monitors",

        // Commands can define a version for automatic '--version' support.
        version: "1.0.0"
        )
    
    @Argument(help: "Wallpath file path")
    var wallpaper: String
    
    mutating func run() {
        let wp = Wallpaper()
        wp.setWallpaper(with: wallpaper)
    }
}

WallpaperSplit.main()
