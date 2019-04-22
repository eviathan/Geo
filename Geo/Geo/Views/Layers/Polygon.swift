//
//  G.swift
//  Geo
//
//  Created by Brian on 20/04/2019.
//  Copyright © 2019 Eviathan. All rights reserved.
//

import Foundation
import Cocoa

// MARK:- NOTES
// 1. Maybe animate lines like this between transitions of shape
// https://www.calayer.com/core-animation/2017/12/25/cashapelayer-in-depth-part-ii.html

class Polygon: CAShapeLayer {
    
    private let color: CGColor  = NSColor.white.cgColor
    
    var centrePoint:Node = Node()
    var nodes: [Node] = [Node]()
    var lines: CAShapeLayer!
    var angle: Double  = 0.0
    var size: CGFloat = 50.0
    var sizeMultuplier: CGFloat = 0.35
    
    var shape: Shape = .triangle {
        didSet {
            addNodesFor(shape: self.shape)
            // createLinesFor(shape: self.shape)
            updatePosition(theta: self.angle)
            setNeedsDisplay()
        }
    }
    
    convenience init(shape: Shape = .triangle, bounds: CGRect) {
        
        self.init()
        self.shape = shape
        self.strokeColor = self.color
        self.lineWidth = 1.0
        self.frame = bounds
        self.bounds = bounds
        self.size = bounds.height * self.sizeMultuplier
        
        self.lines = CAShapeLayer(layer: self)
        self.lines.frame = bounds
        self.lines.bounds = bounds
        
        // Init Nodes
        addNodesFor(shape: self.shape)
        
        // Init Lines
        createLinesFor(shape: self.shape)
        self.addSublayer(self.lines)
        
        // Init CenterPoint
        self.centrePoint.position = CGPoint(x: self.frame.width*0.5, y: self.frame.height*0.5)
        self.addSublayer(self.centrePoint)
        
        updatePosition(theta: 0.0)
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.byValue = NSNumber(value: 2.0*Double.pi)
        rotation.duration = 6
        rotation.repeatCount = Float.infinity
        
        add(rotation, forKey: "lineRotation")
    }
    
    func addNodesFor(shape: Shape) {
        
        let difference = shape.sides - self.nodes.count
        
        if(difference >= 0) {
            for _ in 0..<difference {
                let node = Node(parent: self)
                nodes.append(node)
                self.addSublayer(node)
            }
        } else {
            self.nodes.removeLast(abs(difference))
        }
    }
    
    func createLinesFor(shape: Shape) {
        
        self.lines.sublayers?.removeAll() // TODO: Optimise this like the node layers

        let linePath = NSBezierPath()

        self.lines.fillColor = nil
        self.lines.opacity = 1.0
        self.lines.strokeColor = NSColor.white.cgColor
        self.lines.lineWidth = 1.0
        
        //self.lines.backgroundColor = NSColor.yellow.cgColor

        for (i, node) in self.nodes.enumerated() {
            
            if i == 0 {
                linePath.move(to: node.position)
            }
            else {
                linePath.line(to: node.position)
                
                if i == self.nodes.count - 1  {
                    linePath.line(to: nodes.first!.position)
                }
            }
        }
        
        self.lines.path = linePath.cgPath
    }
    
    func updatePosition(theta: Double) {
        setNodePositions(theta: theta)
        createLinesFor(shape: self.shape)
        //setLinePositions()
    }
    
    private func setNodePositions(theta: Double) {
        self.angle = theta //((self.shape.angle + theta).truncatingRemainder(dividingBy: (Double.pi * 2.0) * Double(i)))
                
        for (i, node) in self.nodes.enumerated() {
            node.position = CGPoint(
                x: sin((self.shape.angle * Double(i)).degreesToRadians()) // Set X Angle
                    * Double(self.size) // Set Distance from centre
                    + (Double(self.frame.height) * 0.5), // Set Offset
                y: cos((self.shape.angle * Double(i)).degreesToRadians()) // Set Y Angle
                    * Double(self.size) // Set Distance from centre
                    + (Double(self.frame.height) * 0.5)) // Set Offset
        }
    }
    
    private func setLinePositions() {
        
    }
}
