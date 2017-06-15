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
    var TableData:[String: AnyObject] = [:]
    
    
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
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        get_data_from_url(url: "http://api.jambase.com/events?artistId=12345")
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
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ArtistTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!
            ArtistTableViewCell

        // Configure the cell...
        cell.ArtistName.text = (TableData["Artists"]![indexPath.row]! as! [String: Any])["Name"]! as? String
        cell.ArtistImage.image = UIImage(named: "icon_artist")
        return cell
    }

    func get_data_from_url(url:String)
    {
        let httpMethod = "GET"
        let timeout = 15
        let url = URL(string: url)
        let urlRequest = URLRequest(url: url!,
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: 15.0)
        let queue = OperationQueue()
        NSURLConnection.sendAsynchronousRequest(
            urlRequest,
            queue: queue,
            completionHandler: {(response, data, error) in
                if (data?.count)! > 0 && error == nil{
                    self.extract_json(jsonData: data!)
                }else if data?.count == 0 && error == nil{
                    print("Nothing was downloaded")
                } else if error != nil{
                    print("Error happened = \(error)")
                }
        }
        )
    }
    
    func extract_json(jsonData:Data)
    {
        var parseError: NSError?
        do {
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: AnyObject] else {
                print("error trying to convert data to JSON")
                return
            }
            if (parseError == nil)
            {
                TableData = json
                print(TableData)
            }
        } catch  {
            print("error trying to convert data to JSON")
            return
        }
        
        
        do_table_refresh();
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
