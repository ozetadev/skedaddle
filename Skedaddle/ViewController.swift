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
    @IBOutlet var nameField:UITextField?
    
    
    var entrySuggestion:InputSuggestion?
    var exitSuggestion:InputSuggestion?
    var selectedDate:NSDate?
    
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
        datePicker!.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        
        
        //text input stylization
        nameField?.layer.cornerRadius = 3.0
        nameField?.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
        
        entryField?.layer.cornerRadius = 3.0
        entryField?.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);

        exitField?.layer.cornerRadius = 3.0
        exitField?.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);

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
    
    @IBAction func triggerAction(sender: UIButton) { // start trip button pressed, move to next screen
        pressUp(sender)
        
        
        if (entryField?.text == "" || exitField?.text == "" || selectedDate == nil) {
            
            // todo, alert
            return;
        }
        
        
        // normally I'd create an event here, but I'm just simulating 1 elapsed second to make it look right
        //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0) * Int64(NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            pushToOverview()
       // } // scratch that, push instantly
    }
    
    @IBAction func pickDate(sender: UIButton) { // date button pressed, show date modal
        pressUp(sender)
        
        
        
        var dateFrame:CGRect = (dateView?.frame)!
        
        if (dateFrame.origin.y <= 500) {
            return
        }
        
        dateFrame.origin.y = 1200
        
        dateView?.frame = dateFrame
        dateView?.hidden = false
        
        entryField?.resignFirstResponder()
        exitField?.resignFirstResponder()
        nameField?.resignFirstResponder()
        
        UIView.animateWithDuration(0.8) { () -> Void in
            dateFrame.origin.y = 330
            self.dateView?.frame = dateFrame
        }
        
    }
    
    @IBAction func dateSelected(sender: UIButton) { // date selected, hide modal
        var dateFrame:CGRect = (dateView?.frame)!
        selectedDate = datePicker?.date
        
        NSLog("SELECTED DATE: %@", selectedDate!)
        
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            dateFrame.origin.y = 1200
            self.dateView?.frame = dateFrame

            }) { (Bool) -> Void in
            self.dateView?.hidden = true
        }

    }
    
    func pushToOverview() { // push to overview
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let info: InfoView = storyboard.instantiateViewControllerWithIdentifier("info") as! InfoView
        self.navigationController?.pushViewController(info, animated: true)
        
        info.departure = entryField!.text
        info.destination = exitField!.text
        info.date = selectedDate
        info.loadPrice()
        spinner?.stopAnimating()
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
}

