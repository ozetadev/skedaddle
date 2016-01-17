//
//  ViewController.swift
//  Skedaddle
//
//  Created by Philip Bernstein on 1/16/16.
//  Copyright © 2016 Philip Bernstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var logo:UIImageView?
    
    @IBOutlet var entryField:UITextField?
    @IBOutlet var exitField:UITextField?
    @IBOutlet var suggestionExit:UILabel?
    @IBOutlet var suggestionEntry:UILabel?
    @IBOutlet var startButton:UIButton?
    @IBOutlet var spinner:UIActivityIndicatorView?
    @IBOutlet var dateButton:UIButton?
    @IBOutlet var datePicker:UIDatePicker?
    @IBOutlet var dateView:UIView?
    
    var entrySuggestion:InputSuggestion?
    var exitSuggestion:InputSuggestion?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logo = UIImageView()
        logo?.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width - 139)/2, 10, 139, 22)
        logo?.image = UIImage(named: "skedaddle.png")
        self.navigationController?.navigationBar.addSubview(logo!)
        self.view.bringSubviewToFront(logo!)
        
        // auto-suggestion from location
        entrySuggestion = InputSuggestion()
        entryField?.delegate = entrySuggestion
        entrySuggestion?.outputArea = suggestionEntry
        
        exitSuggestion = InputSuggestion()
        exitField?.delegate = exitSuggestion
        exitSuggestion?.outputArea = suggestionExit
        
        startButton?.layer.cornerRadius = 4.0
        dateButton?.layer.cornerRadius = 4.0
        
        dateView?.layer.cornerRadius = 3.0
       // datePicker!.setValue(UIColor.whiteColor(), forKeyPath: "textColor")

        /*let ride:Uber = Uber()
        ride.getUberPrice("317 W. 34th Street, 10001", destination: "Times Square, NYC");*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressDown(sender: UIButton) {
        sender.alpha = 0.8
    }

    @IBAction func pressUp(sender: UIButton) {
        sender.alpha = 1.0
    }
    
    @IBAction func triggerAction(sender: UIButton) {
        pressUp(sender)
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.startButton?.titleLabel?.alpha = 0
            self.startButton?.userInteractionEnabled = false // prevents double tap
        }
        
        spinner?.startAnimating()
    }
    
    @IBAction func pickDate(sender: UIButton) {
        pressUp(sender)
        
        var dateFrame:CGRect = (dateView?.frame)!
        dateFrame.origin.y = 1200
        
        dateView?.frame = dateFrame
        dateView?.hidden = false
        
        UIView.animateWithDuration(0.8) { () -> Void in
            dateFrame.origin.y = 20
            self.dateView?.frame = dateFrame
        }
        
    }

}

