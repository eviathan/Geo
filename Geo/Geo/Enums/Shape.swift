//
//  Shape.swift
//  Geo
//
//  Created by Brian on 20/04/2019.
//  Copyright © 2019 Eviathan. All rights reserved.
//

import Foundation

enum Shape {
    case triangle
    case square
    case pentagon
    case hexagon
    case heptagon
    case octagon
    case nonagon
    case decagon
    case nGon(_ sides: Int)
    
    var sides: Int {
        switch self {
        case .triangle: return 3
        case .square: return 4
        case .pentagon: return 5
        case .hexagon: return 6
        case .heptagon: return 7
        case .octagon: return 8
        case .nonagon: return 9
        case .decagon: return 10
        case .nGon(let numberOfSides): return numberOfSides
        }
    }
    
    var angle: Double {
        get {
            switch self {
            case .triangle, .square, .pentagon, .hexagon,
                 .heptagon, .octagon, .nonagon, .decagon: return 360.0 / Double(self.sides)
            case .nGon(let numberOfSides): return 360.0 / Double(numberOfSides)
            }
        }
    }
    
    var interiorAngle: Double {
        get {
            switch self {
            case .triangle, .square, .pentagon, .hexagon,
                 .heptagon, .octagon, .nonagon, .decagon: return self.sumOfInteriorAngles / Double(self.sides)
            case .nGon(let numberOfSides): return self.sumOfInteriorAngles / Double(numberOfSides)
            }
        }
    }
    
    var sumOfInteriorAngles: Double {
        get {
            switch self {
            case .triangle, .square, .pentagon, .hexagon,
                 .heptagon, .octagon, .nonagon, .decagon: return Double(self.sides-2) * 180.0
            case .nGon(let numberOfSides): return Double(numberOfSides-2) * 180.0
            }
        }
    }
}
