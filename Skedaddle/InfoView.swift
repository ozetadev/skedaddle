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
    @IBOutlet var tripLabel:UILabel?
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // totally nonsensical BS. the one thing that I don't understand about swift is them messing with my strings
        var start:String = String(departure)
        var end:String = String(destination)
        
        let comp1:NSArray = start.componentsSeparatedByString(",")
        let comp2:NSArray = end.componentsSeparatedByString(",")
        
        if (comp1.count > 0) {
            start = comp1.firstObject as! String
        }
        if (comp2.count > 0) {
            end = comp2.firstObject as! String
        }
        
        var tripString:String! = start.stringByAppendingString(" to ").stringByAppendingString(end)
        tripString = tripString.stringByReplacingOccurrencesOfString("Optional(\"", withString: "") // genuinely no idea why this is happening. investigate further.
        NSLog("%@", tripString)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tripLabel?.text = tripString
        }

    }
    
    func priceLoaded(tripData:NSDictionary) {
        // uber class has called back w/ data on prices
        if (tripData.objectForKey("prices") == nil) {
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.spinner?.stopAnimating()
                self.uberLabel?.text = "No Estimate"
            }
            return
        }
        
        let prices:NSArray = tripData.objectForKey("prices") as! NSArray
        let price:NSDictionary = prices.firstObject as! NSDictionary
        let estimate:String = price.objectForKey("estimate") as! String
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.spinner?.stopAnimating()
            self.uberLabel?.text = estimate
        }
    }
    
    func loadPrice() {
        // load price from Uber class
        NSLog("LOAD PRICE %@ %@", departure!, destination!)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.spinner?.startAnimating()
        }
        
        let ride:Uber = Uber()
        ride.delegate = self
        ride.getUberPrice(departure!, destination: destination!)
    }
    
    @IBAction func pressDown(sender: UIButton) {
        sender.alpha = 0.8
    }
    
    @IBAction func pressUp(sender: UIButton) {
        sender.alpha = 1.0
    }
    
    @IBAction func buyTicket(sender: UIButton) {
        pressUp(sender)
        
        // push ticketView
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let ticketView: TicketView = storyboard.instantiateViewControllerWithIdentifier("ticket") as! TicketView
        ticketView.heroText = tripLabel?.text;
        ticketView.date = date
        self.navigationController?.pushViewController(ticketView, animated: true)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
}