//
//  ArtistTableViewCell.swift
//  ConcertApp
//
//  Created by Eric  Chung on 6/12/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {

    @IBOutlet weak var ArtistImage: UIImageView!
    @IBOutlet weak var ArtistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
