//
//  VenueViewController.swift
//  ConcertApp
//
//  Created by David Bueno on 6/14/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit

class VenueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var VenueID: String = ""
    var TableData:[String: AnyObject] = [:]
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.register(VenueDetailTableViewCell.self, forCellReuseIdentifier: "VenueDetailCell")
        tableView.delegate = self
        tableView.dataSource = self
        print(VenueID)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        get_data_from_url(url: "http://api.jambase.com/events?venueId=" + VenueID + "&page=0&api_key=buenzrs3exbzhb7f9fbrbvyz")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("hello world")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
        let cellIdentifier = "VenueDetailCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VenueDetailTableViewCell
        
        //if searchController.isActive {
        //let temp : String = makeGetCall(input: "oracle+arena")
        cell.ArtistName.text = ((((TableData["Events"]![indexPath.row] as! [String: Any])["Artists"] as! Array<[String: Any]>)[0])["Name"] as? String)
        print(cell.ArtistName)
        cell.EventDate.text = ((TableData["Events"]![indexPath.row]! as! [String: Any])["Date"]! as? String)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //VenueID = "\((TableData["Venues"]![indexPath.row]! as! [String: Any])["Id"]!)"
        //print((TableData["Venues"]![indexPath.row]! as! [String: Any])["Id"]!)
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
