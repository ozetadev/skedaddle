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
        
        let ride:Uber = Uber()
        ride.getUberPrice("317 W. 34th Street, 10001", destination: "Times Square, NYC");
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
    }

}

