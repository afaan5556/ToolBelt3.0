//
//  FlagUserController.swift
//  ToolBelt
//
//  Created by Afaan on 5/16/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit
import Alamofire

class FlagUserController: UIViewController {
    
    var flagee = Int()
    
    override func viewDidLoad() {
        print(flagee)
    }
    
    
    @IBAction func returnedLateButton(sender: UIButton) {
        flagUser(0)
    }
    
    @IBAction func didntReturnButton(sender: UIButton) {
        flagUser(1)
    }
    
    @IBAction func damagedToolButton(sender: UIButton) {
        flagUser(2)
    }
    
    @IBAction func poorlyMaintainedButton(sender: UIButton) {
        flagUser(3)
    }
    
    @IBAction func otherFlagButton(sender: UIButton) {
        flagUser(4)
    }
    
    func flagUser(reasonID: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
//        Alamofire.request(.POST, "http://localhost:3000/flags", parameters: ["flagger_id": userid, "flagee_id": flagee, "reason": reasonID])
        Alamofire.request(.POST, "https://afternoon-bayou-17340.herokuapp.com/flags", parameters: ["flagger_id": userid, "flagee_id": flagee, "reason": reasonID])
        
    }
    
    
}
