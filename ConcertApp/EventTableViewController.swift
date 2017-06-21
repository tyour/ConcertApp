//
//  EventTableViewController.swift
//  ConcertApp
//
//  Created by David Bueno on 6/7/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit


class EventTableViewController: UITableViewController , UISearchResultsUpdating {
    
    var searchController : UISearchController!
    var data = DataSingleton.getInstance()
    
    //    func updateSearchResults(for searchController: UISearchController) {
    //        tableView.reloadData()
    //    }
    
    var EventName : String = "Event"
    var EventDate: String = "Date"
    var EventImage = #imageLiteral(resourceName: "icon_event")
    var fetchName: String = "\0"
    var fetchLocation: String = "\0"
    //var TableData:[String: AnyObject] = [:]
    //let route = "/venues?zipCode=\(Utils.zipcode)&page=0&api_key=" + Utils.api_key
    //    var TableData:[String: AnyObject] = Utils.makeGetCall(route: "/venues?zipCode=\(Utils.zipcode)&page=0&api_key=" + Utils.api_key)
    var TableData:[String: AnyObject] = Utils.makeGetCall(route: "/venues?zipCode=80465&page=0&api_key=" + Utils.api_key)
    var VenueID: String = ""
    var VenueName: String = ""
    var VenueLocation: String = ""
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var searchResults : [EventObject] = []
    var MyEvent : [EventObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load_events()
        tableView.alwaysBounceVertical = false
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //        self.searchController = UISearchController(searchResultsController: nil)
        //        self.searchController.searchBar.sizeToFit()
        //        self.searchController.hidesNavigationBarDuringPresentation = false
        //        self.searchController.searchResultsUpdater = self
        //        self.searchController.dimsBackgroundDuringPresentation = false
        //        self.tableView.tableHeaderView = self.searchController.searchBar
        //makeGetCall(input: "oracle+arena")
        
        
        //makeGetCall()
        //tableView.reloadData()
        // Cache default data to data object
        //        let route = "/venues?zipCode=\(Utils.zipcode)&page=0&api_key=" + Utils.api_key
        //        data.default_data = Utils.makeGetCall(route: route)
        //        TableData = data.default_data
        //TableData = Utils.makeGetCall(route: route)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        get_data_from_url(url: "http://api.jambase.com/venues?name=oracle&page=0&api_key=sbxzadxwszauykseun6pdj3u")
        
        //get_data_from_url(url: "http://api.jambase.com/venues?name=oracle&page=0&api_key=buenzrs3exbzhb7f9fbrbvyz")
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
        
        if searchController.isActive {
            return searchResults.count
        }
            //else if TableData["Events"]?.count != nil
            //{
            //    return TableData["Events"]!.count
            //}
            
        else
        {
            return TableData["Venues"]!.count
        }
        //return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
        
        let cellIdentifier = "EventCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventTableViewCell
        var cellItem: EventObject
        if searchController.isActive {
            cellItem = searchResults[indexPath.row]
            
        }
        else {
            
            cellItem = MyEvent[indexPath.row]
        }
        
        //if searchController.isActive {
        //let temp : String = makeGetCall(input: "oracle+arena")
        //        cell.EventName.text = (TableData["Venues"]![indexPath.row - 1]! as! [String: Any])["Name"]! as? String
        //        cell.EventDate.text = ((TableData["Venues"]![indexPath.row - 1]! as! [String: Any])["City"]! as? String)! + ", " + ((TableData["Venues"]![indexPath.row]! as! [String: Any])["State"]! as? String)!
        cell.EventName.text = cellItem.iVenue
        cell.EventDate.text = cellItem.iDate
        cell.EventImage.image = UIImage(named: "icon_event")
        //}
        return cell
        
    }
    
    // http://api.jambase.com/venues?name=oracle+arena&page=0&api_key=sbxzadxwszauykseun6pdj3u&o=json
    
    func get_data_from_url(url:String)
    {
        self.activityIndicator.startAnimating()
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
            self.activityIndicator.stopAnimating()
            return
        })
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        VenueID = "\((TableData["Venues"]![indexPath.row]! as! [String: Any])["Id"]!)"
        //print((TableData["Venues"]![indexPath.row]! as! [String: Any])["Id"]!)
        
    }
    //    func makeGetCall() {
    //        let url_str = "http://api.jambase.com/venues?name=oracle+arena&page=0&api_key=sbxzadxwszauykseun6pdj3u"
    //        // Set up the URL request
    //        let todoEndpoint: String = url_str
    //        guard let url = URL(string: todoEndpoint) else {
    //            print("Error: cannot create URL")
    //            return
    //        }
    //        let urlRequest = URLRequest(url: url)
    //
    //        // set up the session
    //        let config = URLSessionConfiguration.default
    //        let session = URLSession(configuration: config)
    //
    //        // make the request
    //        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
    //            // check for any errors
    //            guard error == nil else {
    //                print("error calling GET on /todos/1")
    //                print(error)
    //                return
    //            }
    //            // make sure we got data
    //            guard let responseData = data else {
    //                print("Error: did not receive data")
    //                return
    //            }
    //            // parse the result as JSON, since that's what the API provides
    //            do {
    //                guard let response_data = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
    //                    print("error trying to convert data to JSON")
    //                    return
    //                }
    //                // now we have the todo, let's just print it to prove we can access it
    //                print("\((response_data["Venues"]![0]! as! [String: Any])["Name"]! as! String)")
    //                self.fetchName = (response_data["Venues"]![0]! as! [String: Any])["Name"]! as! String
    //                self.fetchLocation = ((response_data["Venues"]![0]! as! [String: Any])["City"]! as! String) + ", " + ((response_data["Venues"]![0]! as! [String: Any])["State"]! as! String)
    //                self.tableView.beginUpdates()
    //                self.tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    //                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    //                self.tableView.endUpdates()
    //
    //                print("whatup")
    //
    //
    //
    //                // the todo object is a dictionary
    //                // so we just access the title using the "title" key
    //                // so check for a title and print it if we have one
    //                //guard let todoTitle = response_data["title"] as? String else {
    //                //  print("Could not get todo title from JSON")
    //                // return
    //                //}
    //            } catch  {
    //                print("error trying to convert data to JSON")
    //                return
    //            }
    //        })
    //        print("hi")
    //        task.resume()
    //
    //        print("bye")
    //    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
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
    
    func filterContentForSearchText(searchText: String) {
        searchResults = MyEvent.filter({ (ArtistItem: EventObject) -> Bool in
            let nameMatch = ArtistItem.iArtist.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            return nameMatch != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let textToSearch = searchController.searchBar.text {
            filterContentForSearchText(searchText: textToSearch)
            tableView.reloadData()
        }
    }
    func load_events()
    {
        var event_count = 0
        if TableData["Venues"]?.count != nil { event_count = TableData["Venues"]!.count }
        
        for idx in 0..<event_count
        {
            //let date_str: String = (TableData["Events"]![idx] as! [String: Any])["Date"] as! String
            
            MyEvent.append(EventObject(iName: "" , iArtist: " ", iDate: ((TableData["Venues"]![idx]! as! [String: Any])["City"]! as? String)! + ", " + ((TableData["Venues"]![idx]! as! [String: Any])["State"]! as? String)!, iVenue: ((TableData["Venues"]![idx]! as! [String: Any])["Name"]! as? String)!, iURL: "", iList: " "))
        }
        
    }
    
    
    // MARK: - Navigation
    
    let SegueIdentifier = "VenueSegue"
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == SegueIdentifier{
            if let VenueDetail = segue.destination as? VenueViewController{
                if let indexPath = tableView.indexPathForSelectedRow {
                    VenueDetail.VenueID = ((TableData["Venues"]![indexPath.row]! as! [String: Any])["Id"]! as! NSNumber).stringValue
                    VenueDetail.NameStr = MyEvent[indexPath.row].iVenue
                    VenueDetail.LocationStr = MyEvent[indexPath.row].iDate
                }
            }
        }
        
    }
    
    
}
