//
//  Map.swift
//  ToolBelt
//
//  Created by Peter Kang on 5/14/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import MapKit
import Alamofire





class Map: UIViewController {



    func getLatandLong() {Alamofire.request(.GET, "http://localhost:3000") .responseJSON { response in
    if let JSON = response.result.value {

        print("\(JSON)")

        
            }
        }
    }

    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hey")
        getLatandLong()

        var latitude:CLLocationDegrees = 1.001
        
        var longitude:CLLocationDegrees = 1.001
        
        var latDelta:CLLocationDegrees = 0.05
        
        var longDelta:CLLocationDegrees = 0.05
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: false)
        
    }
    
//    func annotate() {
//        
//        var annotation = MKPointAnnotation()
//        
//        annotation.coordinate = location
//        
//        annotation.title = "Niagra Falls"
//        
//        annotation.subtitle = "One day..."
//        
//        map.addAnnotation(annotation)
//    
//    }
    

}
