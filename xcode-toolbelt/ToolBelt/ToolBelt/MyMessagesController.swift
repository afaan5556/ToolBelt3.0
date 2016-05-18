//
//  MyMessagesController.swift
//  ToolBelt
//
//  Created by Phillip Barnett's Mac on 5/17/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//
import UIKit
import Alamofire
import Firebase
class MyMessagesController: UITableViewController {
    
    var otherUserArray = [Int]()
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        getChats()
    }
    
    
    func getChats() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        
        let userIdentifier = "x\(userid)x"
        
        let ref = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/users/\(userIdentifier)")
        
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let chat = snapshot.children
            
            var chatArray = [String]()
            
            for item in chat.allObjects {
                chatArray += Array(arrayLiteral: item.key)
            }
            
            self.otherUserArray = []
            
            for item in chatArray {
                let otherUserIdentifier = item.stringByReplacingOccurrencesOfString(userIdentifier, withString: "")
                let otherUserID = otherUserIdentifier.stringByReplacingOccurrencesOfString("x", withString: "")
                let otherUserNum:Int? = Int(otherUserID)
                self.otherUserArray.append(otherUserNum!)
            }
            
            self.tableView.reloadData()
            
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherUserArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MyMessageCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MyMessageCell
        
        var fullName = String()
        
        Alamofire.request(.GET, "https://afternoon-bayou-17340.herokuapp.com/users/\(otherUserArray[indexPath.row])").responseJSON { response in
            if let JSON = response.result.value {
                
                let firstName = (JSON["first_name"] as? String)!
                let lastName = (JSON["last_name"] as? String)!
                fullName = "\(firstName) \(lastName)"
                
                cell.MyMessageCorrespondentLabel.text = fullName
                
            }
        }
        
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "viewMessageSegue",
            let destination = segue.destinationViewController as? ChatController,
            userIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.contact = (otherUserArray[userIndex] as? Int)!
        }
    }
    
    func tapRowAtIndex(index:Int) {
        let rowToSelect:NSIndexPath = NSIndexPath(forRow: index, inSection: 0)
        self.tableView.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.None)
        self.tableView(self.tableView, didSelectRowAtIndexPath: rowToSelect)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("viewMessageSegue", sender: ToolTableViewCell.self)
    }
}