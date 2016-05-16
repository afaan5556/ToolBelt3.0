//
//  MyToolTableViewController.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit
import Alamofire

class MyToolTableViewController: UITableViewController {

    var mytools = [Tool]()
    
        override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(true)
            loadMyTools()
    
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadMyTools()
        
        
    }
    

 
    
    func loadMyTools() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        Alamofire.request(.GET, "http://afternoon-bayou-17340.herokuapp.com/users/\(userid)/tools").responseJSON { response in
            if let JSON = response.result.value {
                for var i = 0; i < JSON.count; i++ {
                    
                    let title = (JSON[i]["title"] as? String)!
                    
                    var description: String
                    
                    if let des = JSON[i]["description"] as?  NSNull {
                        description = ""
                    } else {
                        description = (JSON[i]["description"] as? String)!
                    }
                    
                    let myTool = Tool(title: title, description: description)
                    
                    self.mytools += [myTool]
                    
                }
                self.tableView.reloadData()
            }
        }
    }
    

    


     override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mytools.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MyToolsTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MyToolsTableViewCell
        let mytool = mytools[indexPath.row]
        
        cell.myToolTitle.text = mytool.title
        cell.myToolDescription.text = mytool.description
        
        return cell
    }

}
