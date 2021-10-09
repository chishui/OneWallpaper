//
//  PathHelper.swift
//  OneWallpaper
//
//  Created by Liyun Xiu on 10/17/20.
//

import Foundation

class PathHelper {
    let fileManager = FileManager.default
    let extensions = ["jpg", "jpeg", "png"]
    
    func getRandomImage(from folder: String) throws -> String {
        let folderUrl = URL(string: folder)
        var images: [URL] = []
        let items = try fileManager.contentsOfDirectory(atPath: folder)
        for item in items {
            guard let file = folderUrl?.appendingPathComponent(item) else {continue}
            if extensions.contains(file.pathExtension) {
                images.append(file)
            }
        }
        
        let index = Int.random(in: 0..<images.count)
        return images[index].absoluteString
    }
}
