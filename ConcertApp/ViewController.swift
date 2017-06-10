//
//  ViewController.swift
//  ConcertApp
//
//  Copyright © 2017 Team2. All rights reserved.
//

//Main Page ViewController
import UIKit

class ViewController: UIViewController {
    
    func makeGetCall () {
        let url_str = "http://api.jambase.com/events?zipCode=95110&radius=5&startDate=2017-06-20&endDate=2017-06-21&page=0&api_key=832t889gh3n8728fzxthr644"
        // Set up the URL request
        let todoEndpoint: String = url_str
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            print("We are in the callback")
            // do stuff with response, data & error here
            print(error ?? "no error")
            print(response ?? "no reponse")
        })
        print("hi")
        task.resume()
        print("bye")
    }
    
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
        
        makeGetCall()
        print("loaded")
        
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

