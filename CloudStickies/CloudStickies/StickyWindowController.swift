//
//  StickyWindowController.swift
//  CloudStickies
//
//  Created by Thiago on 09/02/16.
//  Copyright © 2016 Thiago. All rights reserved.
//

import Cocoa

class StickyWindowController: NSWindowController {

    class func note(lastWindowController: StickyWindowController?) -> StickyWindowController? {
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        
        let id = "StickyWindowController"
        
        if let controller = storyboard.instantiateControllerWithIdentifier(id) as? StickyWindowController {
            
            if let lastWindow = lastWindowController?.window {
                
                let y = lastWindow.frame.origin.y - lastWindow.frame.height - 16
                
                let x = lastWindow.frame.origin.x
                
                let height = lastWindow.frame.height
                
                let width = lastWindow.frame.width
                
                let rect = NSRect(origin: CGPointMake(x,y), size: CGSizeMake(width,height))
                
                controller.window?.setFrame(rect, display: true)
                
            } else {
                
                if let screenFrame = NSScreen.mainScreen()?.frame, window = controller.window {
                    
                    let y = screenFrame.origin.y + screenFrame.height - window.frame.height - 42
                    
                    controller.window?.setFrameOrigin(NSPoint(x: 20, y: y))
                }

            }
        
            return controller
        }
        
        return nil
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
}
