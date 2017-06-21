//
//  BookmarkDetailViewController.swift
//  ConcertApp
//
//  Created by Eric  Chung on 6/21/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit
import CoreData

class BookmarkDetailViewController: UIViewController {
    @IBOutlet weak var event_name: UILabel!
    @IBOutlet weak var event_date: UILabel!
    @IBOutlet weak var event_venue: UILabel!
    @IBOutlet weak var artist_list: UITextView!
    @IBOutlet weak var link_button: UIButton!

    var BookmarkDetail : EventObjectMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.event_name.text = self.BookmarkDetail.iName
        self.event_date.text = self.BookmarkDetail.iDate
        self.event_venue.text = self.BookmarkDetail.iVenue
        self.artist_list.text = self.BookmarkDetail.iList

        // Do any additional setup after loading the view.
        navigationItem.title = self.event_name.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: self.BookmarkDetail.iURL!)! as URL)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
