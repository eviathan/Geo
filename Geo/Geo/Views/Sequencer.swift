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
            self.layer?.sublayers?.forEach({ layer in
                if layer is Polygon {
                    layer.removeFromSuperlayer()
                }
            })
            
            self.layer?.addSublayer(self.polygon)
        }
    }
    
    var centreLine: CAShapeLayer!
 
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
        
        // MARK:- CREATE POLYGON
        self.polygon = Polygon(shape: .nGon(3), bounds: self.frame)
        self.layer?.addSublayer(self.polygon)
        
        // MARK:- Create CentreLine
        self.centreLine = CAShapeLayer(layer: self.layer!)
        createCentreLine(self.frame)
        self.layer?.addSublayer(self.centreLine)
        
    }
    
    func createCentreLine(_ frame: CGRect) {
        
        let path = NSBezierPath()
        path.move(to: CGPoint(x: frame.width * 0.5, y: frame.height))
        path.line(to: CGPoint(x: frame.width * 0.5, y: frame.height * 0.5))
        
        centreLine.path = path.cgPath
        centreLine.strokeColor = NSColor.white.cgColor
        centreLine.lineWidth = 1.0
    }
}
