//
//  DetailViewController.swift
//  ConcertApp
//
//  Created by samfo on 6/18/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var event_name: UILabel!
    @IBOutlet weak var event_date: UILabel!
    @IBOutlet weak var event_venue: UILabel!
    @IBOutlet weak var artist_list: UITextView!
    @IBOutlet weak var link_button: UIButton!
    var website_url: String = ""
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("button pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
