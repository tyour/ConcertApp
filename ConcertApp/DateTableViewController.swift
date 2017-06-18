//
//  DateTableViewController.swift
//  ConcertApp
//
//  Created by samfo on 6/15/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit
import CoreData

class DateTableViewController: UITableViewController {
    
    var TableData:[String: AnyObject] = DataSingleton.getInstance().date_data
    var start_date = ""
    var end_date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if TableData["Events"]?.count != nil { return TableData["Events"]!.count }
        else { return 0 }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DateTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!
        DateTableViewCell
        // Get event name
        cell.event_name.text = ((((TableData["Events"]![indexPath.row] as! [String: Any])["Artists"] as! Array<[String: Any]>)[0])["Name"] as? String)
        print("\(TableData["Events"])")
        
        // Get event date
        let date_str: String = (TableData["Events"]![indexPath.row] as! [String: Any])["Date"] as! String
                    // Get time and date
                    var s_idx = date_str.index(date_str.startIndex, offsetBy:0)
                    var e_idx = date_str.index(date_str.startIndex, offsetBy:10)
                    let date: String = date_str.substring(with: s_idx..<e_idx)
                    s_idx = date_str.index(date_str.startIndex, offsetBy:11)
                    e_idx = date_str.index(date_str.endIndex, offsetBy:0)
                    let time: String = date_str.substring(with: s_idx..<e_idx)
                    
                    // Get date fields
                    var idx = date.index(date.startIndex, offsetBy:4)
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
                    cell.event_date.text = "\(month)-\(day)-\(year) \(the_time)"

        //cell.event_date.text = "yo"
        return cell
    }
    
}
