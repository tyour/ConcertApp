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
        let url_str = "http://api.jambase.com/events?zipCode=95110&radius=50&startDate=2017-06-20&endDate=2017-06-30&page=0&api_key=832t889gh3n8728fzxthr644"
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
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let response_data = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                print("\(response_data["Events"])")
                print("whatup")
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                //guard let todoTitle = response_data["title"] as? String else {
                  //  print("Could not get todo title from JSON")
                   // return
                //}
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
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

