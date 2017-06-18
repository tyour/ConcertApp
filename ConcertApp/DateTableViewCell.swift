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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
