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
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
    
            loadUser()
    
        }
    
    
        func loadUser() {
            let defaults = NSUserDefaults.standardUserDefaults()
            let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
            Alamofire.request(.GET, "http://afternoon-bayou-17340.herokuapp.com/users/\(userid)") .responseJSON { response in
                if let JSON = response.result.value {
                    print("\(JSON)")
                }
                
            }
            
        }
    
    
    
    
}
