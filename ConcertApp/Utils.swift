//
//  Utils.swift
//  ConcertApp
//
//  Created by samfo on 6/13/17.
//  Copyright © 2017 Team2. All rights reserved.
//

/*
 API KEYS
 m4fkuuhzjcsndvp2xmqg4wkb
 832t889gh3n8728fzxthr644
 buenzrs3exbzhb7f9fbrbvyz
 dbb7ha6cq9z9jbrmpf7qks7v
 uwphnbt6vu4f2tebsgfapraw
 49wzchng5akng4j5jpuv3xku
 sbxzadxwszauykseun6pdj3u
 
 w4humvttag232mwgk43rynnw
 f8yz6a4avbczdp2q5nahyx3g
 */

import Foundation

class Utils {
    
    
    static private let SECONDS_IN_DAY: Double = 86400
    static private let API_BASE_URL: String = "http://api.jambase.com"
    static public let api_key = "832t889gh3n8728fzxthr644"
    static public let radius = "50"
    static public let zipcode = "95110"
    
    init() { }
    
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
    
    // Formats date for display, given format from api
    static func getTimeString(date_str: String) -> String {
        // Get time and date
        var s_idx = date_str.index(date_str.startIndex, offsetBy:0)
        var e_idx = date_str.index(date_str.startIndex, offsetBy:10)
        let date: String = date_str.substring(with: s_idx..<e_idx)
        s_idx = date_str.index(date_str.startIndex, offsetBy:11)
        e_idx = date_str.index(date_str.endIndex, offsetBy:0)
        let time: String = date_str.substring(with: s_idx..<e_idx)
        
        // Get date fields
        let idx = date.index(date.startIndex, offsetBy:4)
        let year = date.substring(to: idx)
        s_idx = date.index(date.startIndex, offsetBy:5)
        e_idx = date.index(date.endIndex, offsetBy:-3)
        let month = date.substring(with: s_idx..<e_idx)
        s_idx = date.index(date.startIndex, offsetBy:8)
        e_idx = date.index(date.endIndex, offsetBy:0)
        let day = date.substring(with: s_idx..<e_idx)
        
        //Get time fields
        s_idx = time.index(time.startIndex, offsetBy:0)
        e_idx = time.index(time.startIndex, offsetBy:2)
        var hour = Int(time.substring(with: s_idx..<e_idx))!
        s_idx = time.index(time.startIndex, offsetBy:2)
        e_idx = time.index(time.endIndex, offsetBy:-3)
        let the_rest = time.substring(with: s_idx..<e_idx)
        var ampm = "AM"
        if hour >= 12 {
            if hour == 24 || hour == 12 {
                hour = 12
            }
            else {
                hour = hour - 12
                ampm = "PM"
            }
        }
        if hour == 0 {
            hour = 12
        }
        let the_time: String = String(hour) + the_rest + ampm
        return "\(month)-\(day)-\(year) \(the_time)"
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
