//
//  ViewController.swift
//  ConcertApp
//
//  Copyright © 2017 Team2. All rights reserved.
//

//Main Page ViewController
import UIKit

class ViewController: UIViewController {
    
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button Cluster Actions
    @IBAction func ArtistButtonPress(_ sender: Any) {
        print("ARTISTBUTTONPRESS")
    }
    
    @IBAction func EventButtonPress(_ sender: Any) {
        print("EVENTBUTTONPRESS")
    }
    
    @IBAction func DateButtonPress(_ sender: Any) {
        print("DATEBUTTONPRESS")
    }

    
    @IBAction func LocationButtonPress(_ sender: Any) {
        print("LOCATIONBUTTONPRESS")
    }
    
    
}

