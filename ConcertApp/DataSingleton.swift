//
//  DataSingleton.swift
//  ConcertApp
//
//  Created by samfo on 6/10/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import Foundation
import UIKit

final class DataSingleton {
    static let instance = DataSingleton()
    
    // Stores data that is fetched on launch
    var default_data : [String: AnyObject] = [:]
    // Array of data from api calls made dynamically by user
    var dynamic_data : [ [String: AnyObject] ] = []
    // Stores list of default artists in a simple array
    var artist_list: [String] = []
    
    private init() {}
    
    static func getInstance() -> DataSingleton {
        return .instance
    }
}
