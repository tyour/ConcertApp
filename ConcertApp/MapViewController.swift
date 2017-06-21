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

    var data = DataSingleton.getInstance().default_data
    
    
    var myLocMgr = CLLocationManager()
    var myGeoCoder = CLGeocoder()
    var showPlacemark = CLPlacemark()

    var EventStore : [Double: MapEventObject] = [:]
    var Anns2Display : [MKAnnotation] = []
    var ResultsCount : Int = 10
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let events_obj = data["Events"] as! [Any]
        print("\(events_obj)")
        print("\n\n ===================================================\n\n")
        
        //Reads JSON and creates three arrays that store the values
        for eventitem in events_obj {
            
            let name = ((eventitem as! [String: Any])["Venue"] as! [String: Any])["Name"] as! String
            let lat = ((eventitem as! [String: Any])["Venue"] as! [String: Any])["Latitude"] as! Double
            let long = ((eventitem as! [String: Any])["Venue"] as! [String: Any])["Longitude"] as! Double

            if lat != 0.0 {
                print("\(name)")
                print("\(lat)")
                print("\(long)")
                let EventDist = DistCalc(CurrentLat: (myLocMgr.location?.coordinate.latitude)!,
                                         CurrentLong: (myLocMgr.location?.coordinate.longitude)!,
                                         LatValue: lat,
                                         LongValue: long)
                let obj = MapEventObject(iName: name, iLatitude: lat, iLongitude: long, iDistance: EventDist)
                EventStore[EventDist] = obj
            }
        }
        
        print("Current Location")
        print(myLocMgr.location?.coordinate.latitude)
        print(myLocMgr.location?.coordinate.longitude)
        

        
        //Sets up tableView results
        tableView.delegate = self
        tableView.dataSource = self
        myLocMgr.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            self.myMap.showsUserLocation = true
        }

        myMap.delegate = self
        var EventSorted = [Double](EventStore.keys)
        EventSorted.sort()
        
        //Creates pins
        for i in 0...ResultsCount - 1 {
            let EventKey = EventSorted[i]
            let ConvertDistToMiles = EventStore[EventKey]?.iDistance as! Double * 0.00062137
        
            let annotation = MKPointAnnotation()
            annotation.title = EventStore[EventKey]?.iName as? String
            annotation.subtitle = NSString(format: "%.2f miles away", ConvertDistToMiles) as String
            annotation.coordinate = CLLocationCoordinate2D(latitude: (EventStore[EventKey]?.iLatitude)! , longitude: (EventStore[EventKey]?.iLongitude)!)
            Anns2Display.append(annotation)
        }
        
        self.tableView.reloadData()
        self.myMap.showAnnotations(Anns2Display, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source 
    //======================== TABLEVIEW ========================//
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return ResultsCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
        
        var EventSorted = [Double](EventStore.keys)
        EventSorted.sort()
        
        print("\n\nindexPath.row")
        print(indexPath.row)
        
        
        let EventKey = EventSorted[indexPath.row]
        let ConvertDistToMiles = EventStore[EventKey]?.iDistance as! Double * 0.00062137
        print(EventStore[EventKey]?.iName)
        print(EventStore[EventKey]?.iDistance)
        
        let cellIdentifier = "MapResultCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MapTableViewCell
        print(EventStore[EventKey]?.iName as? String)
        cell.MapResultName.text = EventStore[EventKey]?.iName as? String
        cell.MapResultDistance.text = NSString(format: "%.2f miles away", ConvertDistToMiles) as String
        cell.MapResultImage.image = UIImage(named: "icon_location")
        
        let annotation = MKPointAnnotation()
        annotation.title = EventStore[EventKey]?.iName as? String
        annotation.subtitle = NSString(format: "%.2f miles away", ConvertDistToMiles) as String
        annotation.coordinate = CLLocationCoordinate2D(latitude: (EventStore[EventKey]?.iLatitude)! , longitude: (EventStore[EventKey]?.iLongitude)!)
        Anns2Display.append(annotation)
        
        self.myMap.showAnnotations(Anns2Display, animated: true)
        return cell
    }

    //======================== ADDED FUNCTIONS ========================//
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
