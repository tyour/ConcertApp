//
//  BookmarkTableViewCell.swift
//  ConcertApp
//
//  Created by Eric  Chung on 6/20/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    @IBOutlet weak var EventName: UILabel!
    @IBOutlet weak var EventTime: UILabel!
    @IBOutlet weak var EventImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
