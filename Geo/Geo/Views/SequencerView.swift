//
//  SequencerView.swift
//  Geo
//
//  Created by Brian on 04/04/2019.
//  Copyright © 2019 Eviathan. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
class SequencerView: NSView {
    
 
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        initLayout()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        initLayout()
        
    }
    
    func initLayout() {
        self.layer = CALayer()
        wantsLayer = true
        self.layer?.backgroundColor = NSColor.black.cgColor
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        
    }
}
