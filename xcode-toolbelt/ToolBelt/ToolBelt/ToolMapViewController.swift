//
//  Map.swift
//  ToolBelt
//
//  Created by Peter Kang on 5/14/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.

import Alamofire
import MapKit

class ToolMapViewController: UIViewController {
    
    // MARK - Outlets
    @IBOutlet var map: MKMapView!
    @IBOutlet var toolMapSearchBar: UISearchBar!
    
    
    func getLatandLong() {Alamofire.request(.GET, "http://afternoon-bayou-17340.herokuapp.com/") .responseJSON { response in
        if let JSON = response.result.value {
            
            //        print("\(JSON[0]["owner"])")
            //        print("\(JSON[0]["tool"])")
            
            
            for var i = 0; i < JSON.count; i++ {
                
                print("\(JSON[i])")
                let owner = JSON[i].objectForKey("owner")
                let tool = JSON[i].objectForKey("tool")
                
                
                var lat = owner!["latitude"]?!.doubleValue
                lat = lat! + Double(arc4random_uniform(5))/10000
                var long = owner!["longitude"]?!.doubleValue
                long = long! + Double(arc4random_uniform(5))/10000
                let toolName = tool!["title"]!
                let toolDescription = tool!["description"]!
                var latitude: CLLocationDegrees = lat!
                var longitude: CLLocationDegrees = long!
                
                var latDelta: CLLocationDegrees = 0.01
                var lonDelta: CLLocationDegrees = 0.01
                var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                
                var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                
                self.map.setRegion(region, animated: true)
                
                func annotate() {
                    
                    let annotation = MKPointAnnotation()
                    
                    annotation.coordinate = location
                    
                    annotation.title = "\(toolName!)"
                    
                    annotation.subtitle = "\(toolDescription!)"
                    self.map.addAnnotation(annotation)
                    
                }
                annotate()
            }
            //
            //
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLatandLong()
        
    }
    
    
}