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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let events_obj = data["Events"] as! [Any]
        print("\(events_obj)")
        
        tableView.delegate = self
        tableView.dataSource = self
        myLocMgr.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            self.myMap.showsUserLocation = true
        }

        myMap.delegate = self
        
        self.MapSearchController = UISearchController(searchResultsController: nil)
//        self.MapSearchController.searchBar.sizeToFit()
//        self.tableView.tableHeaderView = self.MapSearchController.searchBar
        
        // Do any additional setup after loading the view.
        
        let mySearchReq = MKLocalSearchRequest()
        mySearchReq.naturalLanguageQuery = searchField.text
        mySearchReq.region = self.myMap.region
        
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
                    annotation.subtitle = item.description
                    annotation.coordinate = (item.placemark.location?.coordinate)!
                    nearbyAnns.append(annotation)
                    self.ResultCount = self.ResultCount + 1
                    print(String(self.ResultCount))
                }
            }
            self.myMap.showAnnotations(nearbyAnns, animated: true)
        })
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
        print("Final Count" + String(ResultCount))
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
    
    
    func ConcertsWithinRange() {
        let ConcertLoc = CLLocation(latitude: 40.730872, longitude: -74.003066)
        let originLoc = CLLocation(latitude: 42.730872, longitude: -72.003066)
        let dist = originLoc.distance(from: ConcertLoc)
        print("Distance between two points is: " + String(dist))
        
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
                    annotation.subtitle = item.description
                    annotation.coordinate = (item.placemark.location?.coordinate)!
                    nearbyAnns.append(annotation)
                }
            }
            self.myMap.showAnnotations(nearbyAnns, animated: true)
            self.tableView.reloadData()
        })
        ConcertsWithinRange()
    }
//    
//    func StartMapSearch(SearchParameter : String){
//        let mySearchReq = MKLocalSearchRequest()
//        mySearchReq.naturalLanguageQuery = SearchParameter
//        mySearchReq.region = self.myMap.region
//        //searchField.text
//        
//        let localSearch = MKLocalSearch(request: mySearchReq)
//        localSearch.start(completionHandler: {
//            response, error in
//            if error != nil {
//                print(error!)
//                return
//            }
//            
//            let myMapItems = response!.mapItems as [MKMapItem]
//            var nearbyAnns : [MKAnnotation] = []
//            self.ResultCount = myMapItems.count
//            print("Search Button Pressed, ResultCount = " + String(self.ResultCount))
//            if myMapItems.count > 0 {
//                for item in myMapItems {
//                    let annotation = MKPointAnnotation()
//                    annotation.title = item.name
//                    annotation.subtitle = item.description
//                    annotation.coordinate = (item.placemark.location?.coordinate)!
//                    nearbyAnns.append(annotation)
//                }
//            }
//            self.myMap.showAnnotations(nearbyAnns, animated: true)
//            self.tableView.reloadData()
//        })
//        ConcertsWithinRange()
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
