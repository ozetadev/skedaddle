//
//  InfoView.swift
//  Skedaddle
//
//  Created by Philip Bernstein on 1/17/16.
//  Copyright © 2016 Philip Bernstein. All rights reserved.
//

import Foundation
import UIKit

class InfoView : UIViewController {
    
    @IBOutlet var reserveButton:UIButton?
    @IBOutlet var outerCircle:UIView?
    @IBOutlet var innerCircle:UIView?
    
    override func viewDidLoad() {
        reserveButton?.layer.cornerRadius = 4.0
        outerCircle?.layer.cornerRadius = (outerCircle?.frame.size.width)!/2
        innerCircle?.layer.cornerRadius = (innerCircle?.frame.size.width)!/2
        
        super.viewDidLoad()
    }
}