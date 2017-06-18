//
//  DateViewController.swift
//  ConcertApp
//
//  Created by samfo on 6/14/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import Foundation
import UIKit

class DateViewController: UIViewController {

    var data = DataSingleton.getInstance()
    @IBOutlet weak var subtitle: UITextView!
    @IBOutlet weak var start_date_text: UITextField!
    @IBOutlet weak var end_date_text: UITextField!
    @IBAction func buttonPressed(_ sender: UIButton) {
        let st = start_date_text.text!
        let ed = end_date_text.text!
        if !input_valid(start: st, end: ed) {
            subtitle.text = "Error: Invalid input\nFormat: YYYY-mm-dd"
            subtitle.textColor = UIColor.red
        }
        else {
            subtitle.text = "Format: YYYY-mm-dd"
            subtitle.textColor = UIColor.black
            data.date_data = Utils.makeGetCall(route: "/events?zipcode=\(Utils.zipcode)&radius=\(Utils.radius)&startDate=\(st)&endDate=\(ed)&page=0&api_key=\(Utils.api_key)")
            self.performSegue(withIdentifier: "toDateTableView", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subtitle.text = "Format: YYYY-mm-dd"
        subtitle.textColor = UIColor.black
    }
    
    func input_valid(start: String, end: String) -> Bool {
        // Make sure format is correct
        if start.range(of: "\\d\\d\\d\\d-\\d\\d-\\d\\d", options: .regularExpression) == nil {
            return false
        }
        if end.range(of: "\\d\\d\\d\\d-\\d\\d-\\d\\d", options: .regularExpression) == nil {
            return false
        }
        // Extract year, month, and day values
        var idx = start.index(start.startIndex, offsetBy:4)
        let start_year = Int(start.substring(to: idx))!
        var s_idx = start.index(start.startIndex, offsetBy:5)
        var e_idx = start.index(start.endIndex, offsetBy:-3)
        let start_month = Int(start.substring(with: s_idx..<e_idx))!
        s_idx = start.index(start.startIndex, offsetBy:8)
        e_idx = start.index(start.endIndex, offsetBy:0)
        let start_day = Int(start.substring(with: s_idx..<e_idx))!
        idx = start.index(end.startIndex, offsetBy:4)
        let end_year = Int(end.substring(to: idx))!
        s_idx = end.index(start.startIndex, offsetBy:5)
        e_idx = end.index(start.endIndex, offsetBy:-3)
        let end_month = Int(end.substring(with: s_idx..<e_idx))!
        s_idx = end.index(start.startIndex, offsetBy:8)
        e_idx = end.index(start.endIndex, offsetBy:0)
        let end_day = Int(end.substring(with: s_idx..<e_idx))!
        // Check validity of values
        if end_year < 2017 || start_year < 2017 || end_year < start_year {
            return false
        }
        if end_year == start_year {
            if end_month < start_month || end_month > 12 || start_month > 12 || end_month < 1 || start_month < 1 {
                return false
            }
            if end_month == start_month {
                if end_day < start_day || end_day > 31 || start_day > 31 || end_day < 1 || start_day < 1 {
                    return false
                }
            }
        }
        // Make sure the start date is not before today's date
        let todays_date = Utils.todaysDate()
        idx = todays_date.index(todays_date.startIndex, offsetBy:4)
        let now_year = Int(todays_date.substring(to: idx))!
        s_idx = todays_date.index(todays_date.startIndex, offsetBy:5)
        e_idx = todays_date.index(todays_date.endIndex, offsetBy:-3)
        let now_month = Int(todays_date.substring(with: s_idx..<e_idx))!
        s_idx = todays_date.index(todays_date.startIndex, offsetBy:8)
        e_idx = todays_date.index(todays_date.endIndex, offsetBy:0)
        let now_day = Int(todays_date.substring(with: s_idx..<e_idx))!
        if now_year > start_year {
            return false
        }
        if now_year == start_year && now_month > start_month {
            return false
        }
        if now_month == start_month && now_day > start_day {
            return false
        }
        return true
    }

}
