//
//  DateTableViewCell.swift
//  ConcertApp
//
//  Created by samfo on 6/17/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import Foundation
import UIKit

class DateTableViewCell: UITableViewCell {

    @IBOutlet weak var data_image: UIImageView!
    @IBOutlet weak var event_name: UILabel!
    @IBOutlet weak var event_date: UILabel!

    
    // Variables to hold data object from API
    let json_response = DataSingleton.getInstance().date_data
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let data: AnyObject? = json_response["Events"] {
            if let date_obj = data!["Date"] {
                if let date_str: String = date_obj! as! String {
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
                    e_idx = time.index(time.endIndex, offsetBy:0)
                    let the_rest = time.substring(with: s_idx..<e_idx)
                    var ampm = "AM"
                    if hour >= 12 {
                        if hour == 24 {
                            hour = 12
                        }
                        else {
                            hour = hour - 12
                            ampm = "PM"
                        }
                    }
                    let the_time: String = String(hour) + the_rest + " " + ampm
                    event_date.text = "\(month)-\(day)-\(year)\n\(the_time))"
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
