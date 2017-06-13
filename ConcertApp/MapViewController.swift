//
//  MapViewController.swift
//  ConcertApp
//
//  Created by Thomas Your on 6/12/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var myMap: MKMapView!
    @IBOutlet var searchField: UITextField!
    
    var myLocMgr = CLLocationManager()
    var myGeoCoder = CLGeocoder()
    var showPlacemark = CLPlacemark()
    
    var toAddr : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLocMgr.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            self.myMap.showsUserLocation = true
        }
        
        myMap.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func searchButtonPress(_ sender: Any) {
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
