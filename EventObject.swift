//
//  EventObject.swift
//  ConcertApp
//
//  Created by Eric  Chung on 6/19/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit

class EventObject: NSObject {
    var iName = ""
    var iArtist = ""
    var iDate = ""
    
    init(iName: String, iArtist: String, iDate: String) {
        self.iName = iName
        self.iArtist = iArtist
        self.iDate = iDate
    }
    
}
