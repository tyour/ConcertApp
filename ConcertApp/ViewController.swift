//
//  ViewController.swift
//  ConcertApp
//
//  Copyright © 2017 Team2. All rights reserved.
//

//Main ViewController
import UIKit

class ViewController: UIViewController {
    

    @IBOutlet var ArtistButton: UIButton!
    @IBOutlet var EventButton: UIButton!
    @IBOutlet var GenreButton: UIButton!
    @IBOutlet var LocationButton: UIButton!
    
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var ButtonClusterBackground: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Formats button cluster
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "concertbackground_formatted"))
        ArtistButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "icon_artist"))
        EventButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "icon_event"))
        GenreButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "icon_genre"))
        LocationButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "icon_location"))
        
        ArtistButton.layer.cornerRadius = 5
        EventButton.layer.cornerRadius = 5
        GenreButton.layer.cornerRadius = 5
        LocationButton.layer.cornerRadius = 5
        
        
        ButtonClusterBackground.layer.masksToBounds = true
        ButtonClusterBackground.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//New test

}

