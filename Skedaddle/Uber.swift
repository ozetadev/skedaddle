//
//  Uber.swift
//  Skedaddle
//
//  Created by Philip Bernstein on 1/17/16.
//  Copyright © 2016 Philip Bernstein. All rights reserved.
//

import Foundation
import UIKit

protocol UberDelegate {
    func priceLoaded(tripData:NSDictionary)
}

// class to interact with both the Google Maps Geometry API & Uber's trip API
class Uber : NSObject {
    
    // constants for authentication
    let clientId:String = "dRTu660ZZsM6paIzfJaCgdNoB2ad34sD"
    let clientSecret:String = "dqqphV7g9FyzJfLAvmd2LxYljEHetPX7hEoByoX5"
    let serverToken:String = "lOEfuSeIPAUZQwkxUwrgEKnwK3LzLAvvwCPN1NHi"
    
    var baseUrl:String = "https://api.uber.com/v1/"
    var priceEstimate:String = "estimates/price"
    
    let delegate:UberDelegate?
    
    override init() {
        self.delegate = nil
        super.init()
    }
    
    func getUberPrice(start: String, destination:String) {
        // step 1: get geolocation of both points in trip
        // to calculate uber price we first need LAT and LONG for each POI for the trip
        
        let geocodeBase:String = "https://maps.googleapis.com/maps/api/geocode/json?sensor=false&address="
        
        let startLocation:String = geocodeBase.stringByAppendingString(start.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        let endLocation:String = geocodeBase.stringByAppendingString(destination.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        var coordinateOne:NSDictionary = ["start":"true"]
        var coordinateTwo:NSDictionary = ["start":"false"]
        
        // start Location
        let url = NSURL(string: startLocation)
        let startTask = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in // url task to download data
            
            if ((error) != nil) { // network problems, etc
                NSLog("Error retrieving results");
                return;
            }
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    let results:NSArray = jsonResult.objectForKey("results") as! NSArray
                    let firstResult:NSDictionary = results.firstObject as! NSDictionary
                    let locationInfo:NSDictionary = firstResult.objectForKey("geometry") as! NSDictionary
                    
                    coordinateOne = locationInfo.objectForKey("location") as! NSDictionary
                    NSLog("%@", coordinateOne);
                    
                    // end locations
                    let endUrl = NSURL(string: endLocation)
                    let endTask = NSURLSession.sharedSession().dataTaskWithURL(endUrl!) {(data, response, error) in // url task to download data
                        
                        if ((error) != nil) { // network problems, etc
                            NSLog("Error retrieving results");
                            return;
                        }
                        do {
                            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                                let results:NSArray = jsonResult.objectForKey("results") as! NSArray
                                let firstResult:NSDictionary = results.firstObject as! NSDictionary
                                let locationInfo:NSDictionary = firstResult.objectForKey("geometry") as! NSDictionary
                                
                                coordinateTwo = locationInfo.objectForKey("location") as! NSDictionary
                                NSLog("%@", coordinateTwo);
                                
                                self.getPriceFromGeometry(coordinateOne, end: coordinateTwo)
                                
                            }
                        } catch let error as NSError {
                            print(error.localizedDescription)
                        }
                    }
                    
                    endTask.resume()
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        startTask.resume()
    }
    
    func getPriceFromGeometry(start: NSDictionary, end: NSDictionary) {

        let startLat:String = (start.objectForKey("lat")?.description)!
        let startLng:String = (start.objectForKey("lng")?.description)!
        
        let endLat:String = (end.objectForKey("lat")?.description)!
        let endLng:String = (end.objectForKey("lng")?.description)!
        
        var apiEndpoint = baseUrl.stringByAppendingString(priceEstimate)
        //start
        apiEndpoint = apiEndpoint + "?start_latitude=" + startLat
        apiEndpoint = apiEndpoint + "&start_longitude=" + startLng
        //end
        apiEndpoint = apiEndpoint + "&end_latitude="  + endLat
        apiEndpoint = apiEndpoint + "&end_longitude=" + endLng
        //token 
        apiEndpoint = apiEndpoint + "&server_token=" + serverToken
        
        
        // end locations
        let endUrl = NSURL(string: apiEndpoint)
        let endTask = NSURLSession.sharedSession().dataTaskWithURL(endUrl!) {(data, response, error) in // url task to download data
            
            if ((error) != nil) { // network problems, etc
                NSLog("Error retrieving results");
                return;
            }
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    self.delegate?.priceLoaded(jsonResult)
                    NSLog("%@", jsonResult)
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        endTask.resume()

    }

    
    
}