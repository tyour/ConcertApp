//
//  ViewController.swift
//  ConcertApp
//
//  Copyright © 2017 Team2. All rights reserved.
//

//Main Page ViewController
import UIKit

class ViewController: UIViewController {
    var data = DataSingleton.getInstance()
    
    //Buttons for navigation cluster
    @IBOutlet var ArtistButton: UIButton!
    @IBOutlet var EventButton: UIButton!
    @IBOutlet var DateButton: UIButton!
    @IBOutlet var LocationButton: UIButton!
    
    //Static objects
    @IBOutlet var TitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Formats button cluster
        //        ArtistButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "icon_artist"))
        //        EventButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "icon_event"))
        //        DateButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "icon_genre"))
        //        LocationButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "icon_location"))
        
        ArtistButton.layer.cornerRadius = 5
        EventButton.layer.cornerRadius = 5
        DateButton.layer.cornerRadius = 5
        LocationButton.layer.cornerRadius = 5
        
        // Get current date and generate future date
        let todays_date = Utils.todaysDate()
        let future_date = Utils.increment(date: todays_date, by: 10) //Get the date of 10 days from now
        let radius = "50"
        let zipcode = "95110"
        
        // Cache default data to data object
        let route = "/events?zipCode=\(zipcode)&radius=\(radius)&startDate=\(todays_date)&endDate=\(future_date)&page=0&api_key=832t889gh3n8728fzxthr644"
        //data.default_data = Utils.makeGetCall(route: route)
        //print("\(data.default_data)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button Cluster Actions
    @IBAction func ArtistButtonPress(_ sender: Any) {
        print("ARTISTBUTTONPRESS")
        performSegue(withIdentifier: "toArtistView", sender: nil)
    }
    
    @IBAction func EventButtonPress(_ sender: Any) {
        print("EVENTBUTTONPRESS")
        performSegue(withIdentifier: "toEventView", sender: nil)
    }
    
    @IBAction func DateButtonPress(_ sender: Any) {
        print("DATEBUTTONPRESS")
        performSegue(withIdentifier: "toDateView", sender: nil)
    }
    
    
    @IBAction func LocationButtonPress(_ sender: Any) {
        print("LOCATIONBUTTONPRESS")
        performSegue(withIdentifier: "toMapView", sender: nil)
    }
    
    
}

