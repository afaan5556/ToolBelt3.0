//
//  newAddEditAddressViewController.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit
import Alamofire

class newAddEditAddressController: UIViewController {
    
    // Outlets
    
    
    @IBOutlet weak var addStreetAddress1: UITextField!
    
    @IBOutlet weak var addStreetAddress2: UITextField!
    
    @IBOutlet weak var addCity: UITextField!
    
    @IBOutlet weak var addState: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    func editUser() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        
        let newStreetAddress1 = String(addStreetAddress1.text!)
        let newStreetAddress2 = String(addStreetAddress2.text!)
        let newCity = String(addCity.text!)
        let newState = String(addState.text!)
        
        let params = ["street_address_1": newStreetAddress1, "street_address_2": newStreetAddress2, "city": newCity, "state": newState]
        
        Alamofire.request(.PUT, "https://afternoon-bayou-17340.herokuapp.com/users/\(userid)", parameters: params) .responseJSON {response in
//        Alamofire.request(.PUT, "http://localhost:3000/users/\(userid)", parameters: params) .responseJSON {response in

            if let responses = response.result.value {
                print(responses)
            }
            print("Sent new address")
        }
        
    }
    
    @IBAction func addEditAddressButton(sender: AnyObject) {
        editUser()
    }
    
    
    
    
    
    
    
    
    
}
