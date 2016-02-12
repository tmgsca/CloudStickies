//
//  StickyWindow.swift
//  CloudStickies
//
//  Created by Thiago on 11/02/16.
//  Copyright © 2016 Thiago. All rights reserved.
//

import Cocoa

class StickyWindow: NSWindow {

    override var canBecomeKeyWindow: Bool { get { return true } }
    override var canBecomeMainWindow: Bool { get { return true } }
}
