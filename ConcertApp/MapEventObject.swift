//
//  MapEventObject.swift
//  ConcertApp
//
//  Created by Thomas Your on 6/20/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit

class MapEventObject: NSObject {

    var iName = ""
    var iLatitude : Double
    var iLongitude: Double
    var iDistance: Double
    
    init(iName: String, iLatitude: Double, iLongitude: Double, iDistance: Double) {
        self.iName = iName
        self.iLatitude = iLatitude
        self.iLongitude = iLongitude
        self.iDistance = iDistance
    }
    
}
