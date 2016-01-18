//
//  Nav.swift
//  Skedaddle
//
//  Created by Philip Bernstein on 1/17/16.
//  Copyright © 2016 Philip Bernstein. All rights reserved.
//

import Foundation
import UIKit

class Nav:UINavigationController { // subclassing UINavigationController to control auto-rotate (unnecessary but efficient)
    override func shouldAutorotate() -> Bool {
        return false
    }
}