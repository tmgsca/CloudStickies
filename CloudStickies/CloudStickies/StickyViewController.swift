//
//  StickyViewController.swift
//  CloudStickies
//
//  Created by Thiago on 08/02/16.
//  Copyright © 2016 Thiago. All rights reserved.
//

import Cocoa

class StickyViewController: NSViewController {

    var initialPosition = NSPoint()
    var editable = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override var representedObject: AnyObject? {
        didSet {
            
        }
    }
    
    @IBAction func disableWindowEditing(sender: NSButton) {
        self.editable = sender.state == NSOffState
    }
    
    override func mouseDown(theEvent: NSEvent) {
        
        guard editable else {
            return
        }
        
        let windowFrame = self.view.window?.frame
        initialPosition = NSEvent.mouseLocation()
        initialPosition.x -= windowFrame!.origin.x
        initialPosition.y -= windowFrame!.origin.y
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        
        guard editable else {
            return
        }
        
        guard initialPosition.y >= 0 else {
            return
        }
        
        var currentPosition = NSPoint()
        var newOrigin = NSPoint()
        
        let screenFrame = NSScreen.mainScreen()?.frame
        let windowFrame = self.view.frame
        
        currentPosition = NSEvent.mouseLocation()
        newOrigin.x = currentPosition.x - initialPosition.x
        newOrigin.y = currentPosition.y - initialPosition.y
        
        if (newOrigin.y + windowFrame.height) > ((screenFrame?.origin.y)! + (screenFrame?.height)!) {
            newOrigin.y = (screenFrame?.origin.y)! + (screenFrame?.height)! - windowFrame.height
        }
        
        self.view.window?.setFrameOrigin(newOrigin)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        guard editable else {
            return
        }
        
        initialPosition.y = -1
    }
   
}

