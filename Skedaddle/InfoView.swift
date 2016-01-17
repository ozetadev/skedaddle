//
//  InfoView.swift
//  Skedaddle
//
//  Created by Philip Bernstein on 1/17/16.
//  Copyright © 2016 Philip Bernstein. All rights reserved.
//

import Foundation
import UIKit

class InfoView : UIViewController, UberDelegate {
    
    @IBOutlet var reserveButton:UIButton?
    @IBOutlet var outerCircle:UIView?
    @IBOutlet var innerCircle:UIView?
    @IBOutlet var spinner:UIActivityIndicatorView?
    @IBOutlet var uberLabel:UILabel?
    
    var date:NSDate?
    var destination:String?
    var departure:String?
    var name:String?
    
    override func viewDidLoad() {
        reserveButton?.layer.cornerRadius = 4.0
        outerCircle?.layer.cornerRadius = (outerCircle?.frame.size.width)!/2
        innerCircle?.layer.cornerRadius = (innerCircle?.frame.size.width)!/2
        super.viewDidLoad()
    }
    
    func priceLoaded(tripData:NSDictionary) {
        let prices:NSArray = tripData.objectForKey("prices") as! NSArray
        let price:NSDictionary = prices.firstObject as! NSDictionary
        let estimate:String = price.objectForKey("estimate") as! String
        
        spinner?.stopAnimating()
        uberLabel?.text = estimate
    }
    
    func loadPrice() {
        NSLog("LOAD PRICE %@ %@", departure!, destination!)
        
        let ride:Uber = Uber()
        ride.delegate = self
        ride.getUberPrice(departure!, destination: destination!)
    }
}