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
class Sequencer: NSControl {
    
    let centerPointRadius: CGFloat = 12.0
    
    var polygon: Polygon! {
        didSet {
            self.layer?.sublayers?.removeAll()
            self.layer?.addSublayer(self.polygon)
        }
    }
 
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        initLayout()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        initLayout()
    }
    
    func initLayout() {
        
        // Set background
        self.layer = CALayer()
        wantsLayer = true
        self.layer?.backgroundColor = NSColor.black.cgColor
        
        // MARK: CREATE POLYGON
        self.polygon = Polygon(shape: .nGon(6), bounds: self.frame)
        self.layer?.addSublayer(self.polygon)
        
        // TODO: Create Single node in center
        // TODO: Create centre line
    }
}
