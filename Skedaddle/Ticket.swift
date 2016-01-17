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
