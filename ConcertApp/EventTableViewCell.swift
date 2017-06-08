//
//  EventTableViewCell.swift
//  ConcertApp
//
//  Created by David Bueno on 6/7/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet var EventImage: UIImageView!
    @IBOutlet var EventName: UILabel!
    @IBOutlet var EventDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
