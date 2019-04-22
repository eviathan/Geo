//
//  DoubleExtensions.swift
//  Geo
//
//  Created by Brian on 20/04/2019.
//  Copyright © 2019 Eviathan. All rights reserved.
//

import Foundation

extension Double {
    
    func degreesToRadians() -> Double {
        return self.truncatingRemainder(dividingBy: 360.0) * Double.pi / 180.0
    }
}
