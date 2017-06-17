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
    
    var TableData:[String: AnyObject] = DataSingleton.getInstance().default_data
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
        print("Hello World")
        if TableData["Events"]?.count != nil
        {
            return TableData["Events"]!.count
        }
            
        else
        {
            return 0
        }
        //return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ArtistTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!
        ArtistTableViewCell
        
        cell.ArtistName.text = ((((TableData["Events"]![indexPath.row] as! [String: Any])["Artists"] as! Array<[String: Any]>)[0])["Name"] as? String)
        print(cell.ArtistName)
        return cell
        
        // Configure the cell...
        //cell.ArtistName.text = (TableData["Artists"]![indexPath.row]! as! [String: Any])["Name"]! as? String
        //cell.ArtistImage.image = UIImage(named: "icon_artist")
        //return cell
    }
    
}
