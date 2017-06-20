//
//  DateTableViewController.swift
//  ConcertApp
//
//  Created by samfo on 6/15/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit
import CoreData

class DateTableViewController: UITableViewController {
    
    var TableData:[String: AnyObject] = DataSingleton.getInstance().date_data
    var start_date = ""
    var end_date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if TableData["Events"]?.count != nil { return TableData["Events"]!.count }
        else { return 0 }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DateTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!
        DateTableViewCell
        // Get event name
        cell.event_name.text = ((((TableData["Events"]![indexPath.row] as! [String: Any])["Artists"] as! Array<[String: Any]>)[0])["Name"] as? String)
        print("\(TableData["Events"])")
        
        // Get event date
        let date_str: String = (TableData["Events"]![indexPath.row] as! [String: Any])["Date"] as! String
        cell.event_date.text = Utils.getTimeString(date_str: date_str)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dateToDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let i = indexPath.row
                let vc = segue.destination as! DetailViewController
                let events_obj = TableData["Events"]![i] as! [String: Any]
                let date_str: String = events_obj["Date"] as! String
                let venue_str: String = (events_obj["Venue"] as! [String: Any])["Name"] as! String
                let url: String = (events_obj["Venue"] as! [String: Any])["Url"] as! String
                let artists = events_obj["Artists"] as! Array<[String: Any]>
                var alist_text = ""
                for a in artists {
                    var aname = String(describing: a["Name"]!)
                    alist_text += "\(aname)\n"
                }
                let ev_name: String = "\(artists[0]["Name"]!)"
                vc.ename = ev_name
                vc.edate = Utils.getTimeString(date_str: date_str)
                vc.evenue = venue_str
                vc.alist = alist_text
                vc.website_url = url
            }
        }
    }
}
