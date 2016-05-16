//
//  AddToolController.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit
import Alamofire


class AddToolController: UIViewController {
    
    @IBOutlet var addToolTitle: UITextField!
    
    
    @IBOutlet var addToolDescription: UITextField!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func addTool() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        
        let title = String(addToolTitle.text!)
        let description = String(addToolDescription.text!)
        
        Alamofire.request(.POST, "https://afternoon-bayou-17340.herokuapp.com/users/\(userid)/tools", parameters: ["title": title, "description": description]) .responseJSON {response in
            
            if let responses = response.result.value {
                print(responses)
            }
            
        }
        
    }


    
    // UI ELEMENTS - IBOutlets
    
    

    

    @IBAction func addToolButton(sender: AnyObject) {
        
        addTool()
        
    }
    
}
