//
//  StickyView.swift
//  CloudStickies
//
//  Created by Thiago on 12/02/16.
//  Copyright © 2016 Thiago. All rights reserved.
//

import Cocoa

class StickyView: NSVisualEffectView {
    
    override func awakeFromNib() {
        self.state = .Active
    }
}
