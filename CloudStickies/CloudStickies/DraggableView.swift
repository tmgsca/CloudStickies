//
//  DraggableView.swift
//  CloudStickies
//
//  Created by Thiago on 12/02/16.
//  Copyright © 2016 Thiago. All rights reserved.
//

import Cocoa

class DraggableView: NSView {

    override func mouseDown(theEvent: NSEvent) {
        superview?.mouseDown(theEvent)
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        superview?.mouseDragged(theEvent)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        superview?.mouseUp(theEvent)
    }
    
}
