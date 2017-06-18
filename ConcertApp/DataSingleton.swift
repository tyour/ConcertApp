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
    
    // Stores data that can be accessed across classes
    var default_data : [String: AnyObject] = [:]
    var date_data : [String: AnyObject] = [:]
    
    private init() {}
    
    static func getInstance() -> DataSingleton {
        return .instance
    }
}
