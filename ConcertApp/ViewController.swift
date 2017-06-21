//
//  ViewController.swift
//  ConcertApp
//
//  Copyright © 2017 Team2. All rights reserved.
//

//Main Page ViewController
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var data = DataSingleton.getInstance()
    
    //Buttons for navigation cluster
    @IBOutlet var ArtistButton: UIButton!
    @IBOutlet var EventButton: UIButton!
    @IBOutlet var DateButton: UIButton!
    @IBOutlet var LocationButton: UIButton!
    
    //Static objects
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var BackgroundLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "concertbackground_formatted"))
        
        
        BackgroundLabel.backgroundColor = UIColor.white
        BackgroundLabel.layer.cornerRadius = 20.0
        BackgroundLabel.clipsToBounds = true
        
        ArtistButton.layer.cornerRadius = 5
        EventButton.layer.cornerRadius = 5
        DateButton.layer.cornerRadius = 5
        LocationButton.layer.cornerRadius = 5
        
        // Get current date and generate future date
        let todays_date = Utils.todaysDate()
        let future_date = Utils.increment(date: todays_date, by: 10) //Get the date of 10 days from now
        
        // Cache default data to data object
        let route = "/events?zipCode=\(Utils.zipcode)&radius=\(Utils.radius)&startDate=\(todays_date)&endDate=\(future_date)&page=0&api_key=" + Utils.api_key
        data.default_data = Utils.makeGetCall(route: route)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button Cluster Actions
    @IBAction func ArtistButtonPress(_ sender: Any) {
        self.performSegue(withIdentifier: "toArtistView", sender: self)
    }
    @IBAction func EventButtonPress(_ sender: Any) {
        self.performSegue(withIdentifier: "toEventView", sender: self)
    }
    @IBAction func DateButtonPress(_ sender: Any) {
        self.performSegue(withIdentifier: "toDateView", sender: self)
    }
    @IBAction func LocationButtonPress(_ sender: Any) {
        self.performSegue(withIdentifier: "toMapView", sender: self)
    }
}

