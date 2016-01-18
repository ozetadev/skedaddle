//
//  TicketView.swift
//  Skedaddle
//
//  Created by Philip Bernstein on 1/17/16.
//  Copyright © 2016 Philip Bernstein. All rights reserved.
//

import Foundation
import UIKit

class TicketView : UIViewController {
    var ticket:Ticket?
    var date:NSDate?
    var heroText:String?
    
    @IBOutlet var ticketArea:UIView?
    @IBOutlet var ticketLabel:UILabel?
    @IBOutlet var dateLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ticketArea?.layer.cornerRadius = 15
        
        // string from date (readable, medium form)
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = .MediumStyle
        
        let dateString = formatter.stringFromDate(date!)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.ticketLabel!.text = self.heroText
            self.dateLabel?.text = dateString
        }
    }

}