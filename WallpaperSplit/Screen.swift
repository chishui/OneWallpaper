//
//  Screen.swift
//  WallpaperSplit
//
//  Created by Liyun Xiu on 10/5/20.
//

import Foundation
import AppKit

struct Screen: Hashable {
    let screenRef: NSScreen
    let name: String
    let frame: NSRect
    
    init(with screen: NSScreen) {
        self.screenRef = screen
        self.name = screen.localizedName
        self.frame = screen.frame
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
