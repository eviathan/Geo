//
//  G.swift
//  Geo
//
//  Created by Brian on 20/04/2019.
//  Copyright © 2019 Eviathan. All rights reserved.
//

import Foundation
import Cocoa

class Polygon: CAShapeLayer {
    
    var shape: Shape = .triangle {
        didSet {
            addNodesFor(shape: self.shape)
            updatePosition(theta: self.angle)
            setNeedsDisplay()
        }
    }
    
    var nodes: [Node] = [Node]()
    var lines: CAShapeLayer!
    var angle: Double  = 0.0
    var size: CGFloat = 50.0
    var sizeMultuplier: CGFloat = 0.35
    
    private let color: CGColor  = NSColor.white.cgColor
    
    convenience init(shape: Shape = .triangle, bounds: CGRect) {
        
        self.init()
        self.shape = shape
        self.strokeColor = self.color
        self.lineWidth = 1.0
        self.frame = bounds
        self.bounds = bounds
        self.size = bounds.height * self.sizeMultuplier
        self.lines = CAShapeLayer(layer: self)
        
        // Init Nodes
        addNodesFor(shape: self.shape)
        
        // Init Lines
        createLinesFor(shape: self.shape)
        self.addSublayer(self.lines)
        
        updatePosition(theta: 0.0)
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
        for (i, node) in self.nodes.enumerated() {
            
            //            let point = CGPoint(x: pointX, y: pointY)
            //
            //            if i == 0 {
            //                starPath.move(to: point)
            //            } else {
            //                starPath.addLine(to: point)
            //            }
            
            //            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            //            UIBezierPath *path = [UIBezierPath bezierPath];
            //
            //            [path moveToPoint:CGPointMake(30, 50)];
            //            [path addLineToPoint:CGPointMake(40, 30)];
            //            [path addLineToPoint:CGPointMake(60, 70)];
            //            [path addLineToPoint:CGPointMake(80, 20)];
            //            [path addLineToPoint:CGPointMake(100, 90)];
            //            [path addLineToPoint:CGPointMake(120, 35)];
            //            [path addLineToPoint:CGPointMake(140, 85)];
            //            [path addLineToPoint:CGPointMake(160, 65)];
            //            [path addLineToPoint:CGPointMake(180, 150)];
            //
            //            shapeLayer.path = path.CGPath;
            //            shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
            //            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            //            [self.GraphView.layer addSublayer:shapeLayer];
        }
    }
    
    func updatePosition(theta: Double) {
        setNodePositions(theta: theta)
        setLinePositions()
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
