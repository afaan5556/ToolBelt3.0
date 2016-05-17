//
//  testViewController.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit
import Alamofire

class testViewController: UIViewController {
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        loadUser()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadUser()
    
    }
    
    
        func loadUser() {
            let defaults = NSUserDefaults.standardUserDefaults()
            let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
            Alamofire.request(.GET, "https://afternoon-bayou-17340.herokuapp.com/users/\(userid)") .responseJSON { response in
//            Alamofire.request(.GET, "http://localhost:3000/users/\(userid)") .responseJSON { response in

                if let JSON = response.result.value {
                    print("\(JSON["first_name"])")
                    print("\(JSON["last_name"])")
                    print("\(JSON["email"])")
                    self.firstName.text = JSON["first_name"] as? String
                    self.lastName.text = JSON["last_name"] as? String
                    self.city.text = JSON["city"] as? String
                    self.state.text = JSON["state"] as? String
                    self.streetadd1.text = JSON["street_address_1"] as? String
                    self.streetadd2.text = JSON["street_address_2"] as? String
                    
                }
                
            }
            
        }
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var streetadd2: UILabel!
    
    @IBOutlet weak var streetadd1: UILabel!
}
