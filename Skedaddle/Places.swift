//
//  Places.swift
//  skedaddle
//
//  Created by Philip Bernstein on 1/15/16.
//  Copyright © 2016 Philip Bernstein. All rights reserved.
//

import Foundation
@objc protocol PlacesDelegate { // marked objc to allow for optional methods
    optional func didLoadNewResults(results: NSArray)
    optional func didFindGeocode(result: NSArray)
}

// stores data from Google Places
class Places : NSObject {
    
    var hasData : Bool?
    var places : NSArray!
    var delegate: PlacesDelegate?
    var pages : Int!
    var nextPage:NSString!
    var lastPage:NSString!
    var currentPrediction:NSString!
    
    override init() {
        self.hasData = false
        self.places = []
        super.init()
    }
    
    func autoComplete(phrase: String) {
        
        if (phrase == "") {
            self.delegate?.didLoadNewResults!([""]) // empty prediction if text is empty
            return;
        }
        
        // creates URL for auto complete by Google Places
        var autoCompleteBase:String = "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=AIzaSyDHSl4JCpz1YOQCoSAzy-MKj1F74s0ST6g&language=en&input="
        let autoCompletePhrase:String = phrase.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        autoCompleteBase.appendContentsOf(autoCompletePhrase)
        
        // network nonsense for autocomplete
        let url = NSURL(string: autoCompleteBase)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in // url task to download data
            
            if ((error) != nil) { // network problems, etc
                NSLog("Error retrieving results");
                return;
            }
            
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary { // parses JSON
                    self.processData(jsonResult)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func processData(dict : NSDictionary) { // process returned data for output
        let predictions : NSArray = dict.objectForKey("predictions") as! NSArray
        
        if (predictions.count > 0) {
            let prediction : NSDictionary = predictions.objectAtIndex(0) as! NSDictionary
            currentPrediction = prediction.valueForKey("description") as! String
            self.delegate?.didLoadNewResults!([currentPrediction])
        }
        else {
            // non predictions
            currentPrediction = ""
            self.delegate?.didLoadNewResults!([])
        }
    }
}