//
//  AddToolController.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit



class AddToolController: UIViewController {
    
    
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
    }
    
    func addTool() {
        let title = addToolTitle.text
        let description = addToolDescription.text
        let newTool = Tool(title: title!, description: description!)
        print(newTool)
        
    }

    
    
    
    
    
    // UI ELEMENTS - IBOutlets
    
    
    @IBOutlet var addToolTitle: UITextField!
    
    
    @IBOutlet var addToolDescription: UITextField!
    

    @IBAction func addToolButton(sender: AnyObject) {
        
        addTool()
        
    }
    
    

}
