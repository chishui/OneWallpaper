//
//  Wallpaper.swift
//  WallpaperSplit
//
//  Created by Liyun Xiu on 10/5/20.
//

import Foundation
import AppKit

class Wallpaper {
    let workspace = NSWorkspace.shared
    let imageCutter = ImageCutter()
    let pathHelper = PathHelper()
    
    // MARK: Set Wallpaper
    public func setWallpaper(with wallpaper: String) {
        let wallpaperUrl = NSURL.fileURL(withPath: wallpaper)
        let m = imageCutter.cut(wallpaperUrl: wallpaperUrl)
        var options = [NSWorkspace.DesktopImageOptionKey: Any]()
        options[.imageScaling] = NSImageScaling.scaleProportionallyUpOrDown.rawValue
        options[.allowClipping] = true
        options[.fillColor] = nil

        for (screen, wallpaperUrl) in m {
            let current = getWallpaper(screen: screen)
            clearCurrentWallpaperIfFileExist(screen: screen, wallpaperUrl: wallpaperUrl)
            setWallpaper(screen: screen, wallpaperUrl: wallpaperUrl, options: options)
//            if current != nil {
//                Thread.sleep(forTimeInterval: 0.3)
//                pathHelper.deleteFileIfExist(file: current)
//            }
        }
    }
    
    private func clearCurrentWallpaperIfFileExist(screen: Screen, wallpaperUrl: URL) {
        if !FileManager.default.fileExists(atPath: wallpaperUrl.path) { return }
        do {
            try workspace.setDesktopImageURL(URL.init(fileURLWithPath: ""), for: screen.screenRef, options: [:])
            Thread.sleep(forTimeInterval: 0.4)
        } catch {
            print(error)
        }
    }
 
    private func setWallpaper(screen: Screen, wallpaperUrl: URL, options: [NSWorkspace.DesktopImageOptionKey: Any]) {
        do {
            try workspace.setDesktopImageURL(wallpaperUrl, for: screen.screenRef, options: options)
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    private func getWallpaper(screen: Screen) -> URL {
        return NSWorkspace.shared.desktopImageURL(for: screen.screenRef)!
    }
}
