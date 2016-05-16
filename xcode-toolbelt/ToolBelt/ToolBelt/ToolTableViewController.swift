//
//  ToolTableViewController.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit
import Alamofire
import MapKit


class ToolTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    // MARK - Outlets
    
    
    @IBOutlet weak var toolListSearchBar: UISearchBar!
    

    
    // MARK - Load sample tools
    
    let locationManager = CLLocationManager()
    var currentLat: CLLocationDegrees = 0.0
    var currentLong: CLLocationDegrees = 0.0
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let location = locations.last! as CLLocation
        currentLat = location.coordinate.latitude
        currentLong = location.coordinate.longitude
    }

    
    var tools = [Tool]()
    
    
    
    
    func searchBarSearchButtonClicked( searchbar: UISearchBar)
    {
        searchbar.resignFirstResponder()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        
        let searchTerm = String(toolListSearchBar.text!)
        
        print(searchTerm)
        
        Alamofire.request(.GET, "http://afternoon-bayou-17340.herokuapp.com/tools/search", parameters: ["keyword": searchTerm, "latitude": currentLat, "longitude": currentLong]) .responseJSON {response in
            if let JSON = response.result.value {
                print("\(JSON)")
                
                for var i = 0; i < JSON.count; i++ {
                    
                    let owner = JSON[i].objectForKey("owner")
                    let tool = JSON[i].objectForKey("tool")
                    let title = tool!["title"] as? String!
                    
                    var description: String
                    
                    if let des = tool!["description"] as?  NSNull {
                        description = ""
                    } else {
                        description = (tool!["description"] as? String!)!
                    }
                    
                    let myTool = Tool(title: title!, description: description)
                    
                    self.tools += [myTool]
                 }
                self.tableView.reloadData()
                
            } else {
                print("Sent search term, but no response")
            }
        }
        
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        
        // Load the sample data.
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tools.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ToolTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ToolTableViewCell
        let tool = tools[indexPath.row]
        
        cell.toolListTitle.text = tool.title
        cell.toolListDescription.text = tool.description
        
        return cell
    }
    
    
    
    

}
