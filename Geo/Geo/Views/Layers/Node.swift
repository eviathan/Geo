//
//  Node.swift
//  Geo
//
//  Created by Brian on 20/04/2019.
//  Copyright © 2019 Eviathan. All rights reserved.
//

import Foundation
import Cocoa

class Node: CAShapeLayer {
    
    var parent: Polygon!
    let size: CGFloat = 10.0
    
    convenience init(parent: Polygon) {
        
        self.init()
        self.parent = parent
        self.strokeColor = parent.strokeColor
        self.lineWidth = parent.lineWidth
        self.frame = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        self.bounds = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        
        let ring = CAShapeLayer()
        ring.frame = self.frame
        ring.lineWidth = self.parent.lineWidth
        ring.strokeColor = self.strokeColor
        
        let ringPath = NSBezierPath(roundedRect: ring.frame, xRadius: size, yRadius: size)
        ring.path = ringPath.cgPath
        
        let centre = CAShapeLayer()
        let centreSize = size * 0.15
        centre.frame = self.frame
        centre.lineWidth = self.parent.lineWidth
        centre.strokeColor = self.strokeColor
        centre.fillColor = self.strokeColor
        
        let centerPath = NSBezierPath(roundedRect: CGRect(x: (self.frame.width * 0.5) - (centreSize * 0.5), y: (self.frame.height * 0.5) - (centreSize * 0.5), width: centreSize, height: centreSize), xRadius: size, yRadius: size)
        centre.path = centerPath.cgPath
        
        self.addSublayer(ring)
        self.addSublayer(centre)
    }
}
