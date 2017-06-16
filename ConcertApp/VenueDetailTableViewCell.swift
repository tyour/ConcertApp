//
//  VenueDetailTableViewCell.swift
//  ConcertApp
//
//  Created by David Bueno on 6/15/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit

class VenueDetailTableViewCell: UITableViewCell {

    @IBOutlet var ArtistName: UILabel!
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
