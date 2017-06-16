//
//  ArtistTableViewController.swift
//  ConcertApp
//
//  Created by Eric  Chung on 6/7/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit
import CoreData

class ArtistTableViewController: UITableViewController, UISearchResultsUpdating {

    var searchController : UISearchController!
    var artistName : [String] = ["ArtistName"]
    var artistImage : [UIImage] = [#imageLiteral(resourceName: "icon_artist")]
    var fetchName: String = "\0"
    var TableData:[String: AnyObject] = DataSingleton.getInstance().default_data
    
    
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }

   //var searchResults = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        // self.searchController = UISearchController(searchResultsController: nil)
        // self.searchController.searchBar.sizeToFit()
        // self.searchController.hidesNavigationBarDuringPresentation = false
        // self.searchController.searchResultsUpdater = self
        // self.searchController.dimsBackgroundDuringPresentation = false
        // self.tableView.tableHeaderView = self.searchController.searchBar
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
    
    func do_table_refresh()
    {
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            return
        })
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
       return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
