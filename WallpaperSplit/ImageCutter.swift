//
//  ImageCutter.swift
//  WallpaperSplit
//
//  Created by Liyun Xiu on 10/5/20.
//

import Foundation
import AppKit

class ImageCutter {
    lazy var monitorInfo = MonitorInfo()
    lazy var pathHelper = PathHelper()
    
    public func cut(wallpaperUrl: URL) -> [Screen: URL] {
        guard let frame = monitorInfo.getFrame(), let imagePath = pathHelper.getImageFolder() else { return [:] }
        var image = NSImage(byReferencing: wallpaperUrl)
        let ret = preprocessImage(monitorFrame: frame, image: image)!
        image = ret.image!
        let factor = ret.factor;
        var m = [Screen: URL]()
        for screen in monitorInfo.screens {
            let imageFrame = NSRect(origin: NSPoint(x: screen.frame.origin.x - frame.minX, y: frame.maxY - screen.frame.maxY), size: screen.frame.size)
            let sub = crop(frame: imageFrame, image: image, factor: factor)
            do {
                //let subImageUrl = imagePath.appendingPathComponent("\(screen.name)_\(NSDate().timeIntervalSince1970).png")
                let subImageUrl = imagePath.appendingPathComponent("\(screen.name).png")
                try sub?.savePngTo(url: subImageUrl)
                m[screen] = subImageUrl
            } catch {
                print(error)
            }
        }
        return m
    }
 
    func preprocessImage(monitorFrame: NSRect, image: NSImage) -> (image: NSImage?, factor: CGFloat)? {
        guard let scaledImage = image.resizeMaintainingAspectRatio(withSize: monitorFrame.size) else { return nil }
        var x: CGFloat = 0, y: CGFloat = 0
        if scaledImage.width > monitorFrame.width {
            x = (scaledImage.width - monitorFrame.width) / 2
        } else {
            y = (scaledImage.height - monitorFrame.height) / 2
        }
    
        let cropFrame = NSRect(x: x, y: y, width: monitorFrame.width, height: monitorFrame.height)
        let cgImage = scaledImage.asCGImage()
        let factor = (CGFloat) (cgImage!.width) / monitorFrame.width
        let newImage = crop(frame: cropFrame, image: scaledImage, factor: factor)
        return (newImage, factor)
    }

    func crop(frame: NSRect, image: NSImage, factor: CGFloat) -> NSImage? {
        let cgImage = image.asCGImage()
        let newCgImage = cgImage?.cropping(to: NSRect(x: frame.origin.x*factor, y: frame.origin.y*factor, width: frame.width*factor, height: frame.height*factor))
        return NSImage(cgImage: newCgImage!, size: frame.size)
    }
}
