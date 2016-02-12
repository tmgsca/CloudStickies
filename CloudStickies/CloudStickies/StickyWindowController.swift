//
//  StickyWindowController.swift
//  CloudStickies
//
//  Created by Thiago on 09/02/16.
//  Copyright © 2016 Thiago. All rights reserved.
//

import Cocoa

class StickyWindowController: NSWindowController {
    
    var noteID: Int?
    
    class func note(lastWindowController: StickyWindowController?, id: Int?) -> StickyWindowController? {
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        
        let controllerId = "StickyWindowController"
        
        if let controller = storyboard.instantiateControllerWithIdentifier(controllerId) as? StickyWindowController {
            
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
            
            if let id = id {
                
                if let _ = StickyNote.byId(id) {
                    
                    controller.noteID = id
                }
            }
            
            controller.setupNote()
            
            return controller
        }
        
        return nil
    }
    
    class func note(lastWindowController: StickyWindowController?) -> StickyWindowController? {
        
       return note(lastWindowController, id: nil)
    }
    
    override func close() {
        
        if let contentController = self.window?.contentViewController as? StickyViewController {
            
            if let id = contentController.note?.id, note = StickyNote.byId(id) {
                
                StickyNote.delete(note)
            }
        }
        
        super.close()
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
    }
    
    func setupNote() {
    
        if let viewController = self.window?.contentViewController as? StickyViewController {
            
            viewController.noteID = self.noteID
            
            viewController.setupNote()
        }
    }
}
