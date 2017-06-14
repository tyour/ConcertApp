//
//  Utils.swift
//  ConcertApp
//
//  Created by samfo on 6/13/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import Foundation

class Utils {
    
    
    static private let SECONDS_IN_DAY: Double = 86400
    static private let API_BASE_URL: String = "http://api.jambase.com"
    
    
    
    // Empty constructor
    init() {}
    
    
    
    // Generates a date string in format yyy-MM-dd to pass to jambase api
    static func todaysDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        return result
    }
    
    
    
    // Increments a date string in format yyyy-MM-dd by a number of days
    static func increment(date: String, by: Double) -> String {
        //First convert string to Date type
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var d = formatter.date(from: date)!
        // Increment date
        d += (SECONDS_IN_DAY * by)
        // Convert back to string and return
        let result = formatter.string(from: d)
        return result
    }
    
    
    
    // Makes a get call to jambase api
    static func makeGetCall(route: String) -> [String: AnyObject] {
        
        var request_complete = false
        var data_holder: [String: AnyObject] = [:]
        let url_str = API_BASE_URL + route
        
        // Set up the URL request
        let apiEndpoint: String = url_str
        guard let url = URL(string: apiEndpoint) else {
            print("Error: cannot create URL")
            return [:]
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error contacting API")
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON (1)")
                    return
                }
                data_holder = json
                request_complete = true
            } catch  {
                print("error trying to convert data to JSON (2)")
                return
            }
        })
        task.resume()
        while(!request_complete) { continue }
        return data_holder
    }
    
}
