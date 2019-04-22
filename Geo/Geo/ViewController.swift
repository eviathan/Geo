//
//  ViewController.swift
//  Geo
//
//  Created by Brian on 04/04/2019.
//  Copyright © 2019 Eviathan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var sequencerView: Sequencer!
    
    @IBOutlet weak var sidesSlider: NSSlider!
    @IBOutlet weak var angleSlider: NSSlider!
    @IBOutlet weak var copiesSlider: NSSlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    var lastValue: Int = 0
    @IBAction func sliderChanged(_ sender: NSSlider) {
        
        let val = Int(sender.intValue)
        
        if lastValue != val {
            sequencerView.polygon = Polygon(shape: .nGon(val), bounds: sequencerView.bounds)
        }
        
        lastValue = val
    }
}

