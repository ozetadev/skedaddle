//
//  InputSuggestion.swift
//  Skedaddle
//
//  Created by Philip Bernstein on 1/16/16.
//  Copyright © 2016 Philip Bernstein. All rights reserved.
//

import Foundation
import UIKit

class InputSuggestion : NSObject, UITextFieldDelegate, PlacesDelegate {
    
    var suggestor:Places? // class that communicates w/ google places
    var outputArea:UILabel? // assigned by view controller as location for suggestion text to be output
    var suggested:String?
    
    func didLoadNewResults(results: NSArray) {
        if (results.count > 0) { // results
            let result:String = results.objectAtIndex(0) as! String
            self.suggested = result
            
            // main queue (ui update)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.outputArea!.text = self.suggested
            });
            
            NSLog("%@", result)
        }
        else { // nah
            NSLog("No match")
            self.suggested = ""
            // again w/ main queue for UI
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.outputArea!.text = self.suggested
            });

        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool { // suggestion text overrides at this point
        
        if (suggested == "") {
            return true
        }
        
        textField.text = suggested
        outputArea?.hidden = true
        suggested = ""
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) { // show auto-suggest
        outputArea?.hidden = false
    }

    func textFieldDidEndEditing(textField: UITextField) { // hide auto-suggest
        outputArea?.hidden = true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        if (string == "" && range.location == 0) {
            outputArea?.hidden = true
            outputArea?.text = ""
            suggested = ""
            return true
        }
        
        if suggestor == nil {
            suggestor = Places()
        }
        
        suggestor?.delegate = self
        suggestor?.autoComplete(textField.text!)
        outputArea?.hidden = false
        
        return true;
    }


}