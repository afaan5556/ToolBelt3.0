//
//  FlagUserFormController.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit
import Alamofire




class FlagUserFormController: UITableViewController {
    
    
    //    func flagUser() {
    //
    //        let defaults = NSUserDefaults.standardUserDefaults()
    //        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
    

    
    var reasons = ["Damaged Tool", "Returned Tool Late", "Didn't Return Tool", "Tool Was Poorly Maintained", "Other"]

    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasons.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "FlagUserReasonCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FlagUserReasonCell
        let reason = reasons[indexPath.row]
        
        cell.flagReason.text = reason
        
        return cell
    }
    
    
    
    @IBAction func flagUser(sender: AnyObject) {
        
        
        
    }

    

}
