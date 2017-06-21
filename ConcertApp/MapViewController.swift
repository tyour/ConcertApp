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

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var myMap: MKMapView!
    
    @IBOutlet var searchField: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    var MapSearchController : UISearchController!
    var matchingItems:[MKMapItem] = []
    var data = DataSingleton.getInstance().default_data
    
    
    var myLocMgr = CLLocationManager()
    var myGeoCoder = CLGeocoder()
    var showPlacemark = CLPlacemark()
    
    var toAddr : String?
    var ResultCount = 1
    var EventStore : [Double: MapEventObject] = [:]
    var Results2Display : [MapEventObject] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let events_obj = data["Events"] as! [Any]
        print("\(events_obj)")
        
        //Reads JSON and creates three arrays that store the values
        for eventitem in events_obj {
            
            var name = ((eventitem as! [String: Any])["Venue"] as! [String: Any])["Name"] as! String
            var lat = ((eventitem as! [String: Any])["Venue"] as! [String: Any])["Latitude"] as! Double
            var long = ((eventitem as! [String: Any])["Venue"] as! [String: Any])["Longitude"] as! Double

            if lat != 0.0 {
                print("\(name)")
                print("\(lat)")
                print("\(long)")
                let EventDist = DistCalc(CurrentLat: (myLocMgr.location?.coordinate.latitude)!,
                                         CurrentLong: (myLocMgr.location?.coordinate.longitude)!,
                                         LatValue: lat,
                                         LongValue: long)
                let obj = MapEventObject(iName: name, iLatitude: lat, iLongitude: long, iDistance: EventDist)
                EventStore.updateValue(obj, forKey: EventDist)
            }
        }
        
        print("Current Location")
        print(myLocMgr.location?.coordinate.latitude)
        print(myLocMgr.location?.coordinate.longitude)
        
        // EventStore = [1.0:Foo], [1.5:Bar], [0.5:Baz], [0.2:Boo]
        
//       var sortedKeys = Array(EventStore.keys.sorted())
//       
//        print("\nSorted Keys")
//        print(sortedKeys)
//        print(sortedKeys.endIndex)
//        for i in 0...sortedKeys.endIndex - 1 {
//            print(sortedKeys[i])
//            print(EventStore[sortedKeys[i]])
//        }

        
        //Sets up tableView results
        tableView.delegate = self
        tableView.dataSource = self
        myLocMgr.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            self.myMap.showsUserLocation = true
        }

        myMap.delegate = self
        self.MapSearchController = UISearchController(searchResultsController: nil)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return ResultCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {

        
        let cellIdentifier = "MapResultCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MapTableViewCell
        cell.MapResultName.text = "Placeholder Name"
        cell.MapResultDistance.text = "10 Miles"
        cell.MapResultImage.image = UIImage(named: "icon_location")

        return cell
        
    }

    
    @IBAction func searchButtonPress(_ sender: Any) {
        StartMapSearch(SearchParameter: searchField.text!)
        self.tableView.reloadData()
    }
    
    
    func DistCalc(CurrentLat: Double, CurrentLong: Double, LatValue: Double, LongValue: Double) -> Double {
        let ConcertLoc = CLLocation(latitude: LatValue  , longitude: LongValue)
        let OriginLoc = CLLocation(latitude: CurrentLat  , longitude: CurrentLong)
        let dist = OriginLoc.distance(from: ConcertLoc)
        print("Distance between two points is: " + String(dist))
        
        return dist
    }
    
    func StartMapSearch(SearchParameter : String){
        let mySearchReq = MKLocalSearchRequest()
        mySearchReq.naturalLanguageQuery = SearchParameter
        mySearchReq.region = self.myMap.region
        //searchField.text
        
        let localSearch = MKLocalSearch(request: mySearchReq)
        localSearch.start(completionHandler: {
            response, error in
            if error != nil {
                print(error!)
                return
            }
            
            let myMapItems = response!.mapItems as [MKMapItem]
            var nearbyAnns : [MKAnnotation] = []
            self.ResultCount = myMapItems.count
            print("Search Button Pressed, ResultCount = " + String(self.ResultCount))
            
            if myMapItems.count > 0 {
                for item in myMapItems {
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.subtitle = "You are here"
                    annotation.coordinate = (item.placemark.location?.coordinate)!
                    nearbyAnns.append(annotation)
                }
            }
            self.myMap.showAnnotations(nearbyAnns, animated: true)
            self.tableView.reloadData()
        })
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
