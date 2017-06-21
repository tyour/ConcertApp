//
//  DetailViewController.swift
//  ConcertApp
//
//  Created by samfo on 6/18/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailViewController: UIViewController {
    @IBOutlet weak var event_name: UILabel!
    @IBOutlet weak var event_date: UILabel!
    @IBOutlet weak var event_venue: UILabel!
    @IBOutlet weak var artist_list: UITextView!
    @IBOutlet weak var link_button: UIButton!
    
    // SET THESE
    var website_url: String = ""
    var ename : String!
    var edate : String!
    var evenue : String!
    var alist: String!
    
    // CoreData for Bookmarks
    var newBookmark : EventObjectMO!
    @IBAction func buttonPressed(_ sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: website_url)! as URL)
    }
    
    @IBAction func bookmarkPressed(_ sender: Any) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            newBookmark = EventObjectMO(context: appDelegate.persistentContainer.viewContext)
            newBookmark.iName = self.ename
            newBookmark.iVenue = self.evenue
            newBookmark.iDate = self.edate
            newBookmark.iList = self.alist
            newBookmark.iURL = self.website_url
            
            appDelegate.saveContext()
        }
        //let bookmarkAlert = UIAlertController(title: "Bookmark Created!", message: "Revisit this page in your Bookmarks", preferredStyle: UIAlertControllerStyle.alert)
       // bookmarkAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
       // self.present(bookmarkAlert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.event_name.text = self.ename
        self.event_date.text = self.edate
        self.event_venue.text = self.evenue
        self.artist_list.text = self.alist
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
