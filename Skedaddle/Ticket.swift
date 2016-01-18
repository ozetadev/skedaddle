//
//  Ticket.swift
//  skedaddle
//
//  Created by Philip Bernstein on 1/15/16.
//  Copyright © 2016 Philip Bernstein. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

// self contained barcode generator / animation
class Ticket: UIView {
    
    // outline of resources we need
    var barcodeView : UIImage!
    var imageContainer : UIImageView!
    
    
    func initialize() { // sets up view (default text)
        barcodeView = self.generateBarcode("Passenger Name: Philip Bernstein \n ID Number: 113848922")
        imageContainer = UIImageView()
        imageContainer.image = barcodeView
        imageContainer.frame = CGRectMake(0, 0, 150, 150)
        self.addSubview(imageContainer)
        
        // animation 1
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let animation:CATransition = CATransition()
            animation.delegate = self
            animation.duration = 2
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.type = "suckEffect"
            animation.fillMode = kCAFillModeRemoved
            animation.endProgress=1.0
            animation.removedOnCompletion = false
            animation.repeatCount = 9999999999999999999
            
            self.imageContainer.layer.addAnimation(animation, forKey: nil)
        }
        
        //overlap animation (regular CATransitions allow a minute moment of non-ripple)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1) * Int64(NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                let animation:CATransition = CATransition()
                animation.delegate = self
                animation.duration = 0.85
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
                animation.type = "rippleEffect"
                animation.fillMode = kCAFillModeRemoved
                animation.endProgress=1.0
                animation.removedOnCompletion = false
                animation.repeatCount = 9999999999999999999
                
                self.layer.addAnimation(animation, forKey: nil)
            }
        }
        
        self.backgroundColor = UIColor.clearColor()
        imageContainer.backgroundColor = UIColor.clearColor()
    }
    
    func generateWithText(text : String) { // allow customization
        barcodeView = self.generateBarcode(text)
        self.imageContainer.image = barcodeView
    }
    
    func generateWithObject(object: NSDictionary) {
        // todo
    }
        
    required init?(coder aDecoder: NSCoder) { // initializes through IB
        super.init(coder: aDecoder);
        initialize();
    }
    
    func generateBarcode(string: NSString)->UIImage { // core image to create a barcode from text
        
        let data = string.dataUsingEncoding(NSASCIIStringEncoding)
        let filter = CIFilter(name: "CIQRCodeGenerator") // creates basic QR code
        filter!.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransformMakeScale(5.0, 5.0) // expands QR code image ( starts out as blurry )
        
        return UIImage(CIImage: filter!.outputImage!.imageByApplyingTransform(transform)) // transforms then returns
    }
    
    func animateBarcode() { // obfuscate barcode from screenshots or replication
        
    }
    
}
