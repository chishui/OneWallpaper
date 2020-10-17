//
//  MonitorInfo.swift
//  WallpaperSplit
//
//  Created by Liyun Xiu on 10/4/20.
//

import Foundation
import AppKit

// frame coordinate
// |
// |
// +-----

// image coordinate
// +----
// |
// |

class MonitorInfo {
    let workspace = NSWorkspace.shared
    var screens: [Screen] = []
    var frames: [NSRect] = []
    
    init() {
        loadScreen()
    }

    public func getFrame() -> NSRect? {
        var unionFrame: NSRect? = nil;
        for screen in NSScreen.screens {
            if unionFrame == nil {
                unionFrame = screen.frame
            } else {
                unionFrame = unionFrame!.union(screen.frame)
            }
        }
        return unionFrame
    }

    public func loadScreen() {
        for screen in NSScreen.screens {
            self.screens.append(Screen(with: screen))
        }
    }
}
