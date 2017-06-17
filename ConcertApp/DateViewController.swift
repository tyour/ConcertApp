//
//  DateViewController.swift
//  ConcertApp
//
//  Created by samfo on 6/14/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import Foundation
import UIKit

class DateViewController: UIViewController {

    var data = DataSingleton.getInstance()
    @IBOutlet weak var subtitle: UITextView!
    @IBOutlet weak var start_date_text: UITextField!
    @IBOutlet weak var end_date_text: UITextField!
    @IBAction func buttonPressed(_ sender: UIButton) {
   
    }

}
