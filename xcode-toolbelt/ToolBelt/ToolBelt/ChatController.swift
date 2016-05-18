//
//  ChatController.swift
//  ToolBelt
//
//  Created by Afaan on 5/16/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class ChatController: UIViewController {
    
    
    @IBOutlet var chatWindow: UITextView!
    
    @IBOutlet var textField: UITextField!
    
    var contact = Int()
    var name = String()
    var convo = String()
    
    
    var ref = Firebase()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "flagUserSegue") {
            let destination : FlagUserController = segue.destinationViewController as! FlagUserController
            destination.flagee = contact
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        print("contact: \(contact)")
        print("user: \(userid)")
        var arrayOfUsers: [String] = ["\(userid)","\(contact)"]
        arrayOfUsers = arrayOfUsers.sort()
        //        var convo = arrayOfUsers.joinWithSeparator("xx")
        convo = "x\(arrayOfUsers[0])xx\(arrayOfUsers[1])x"
        
        Alamofire.request(.GET, "https://afternoon-bayou-17340.herokuapp.com/users/\(userid)") .responseJSON { response in
            //            Alamofire.request(.GET, "http://localhost:3000/users/\(userid)") .responseJSON { response in
            
            if let JSON = response.result.value {
                print("\(JSON["first_name"])")
                self.name = (JSON["first_name"] as? String)!
                
                
            }
            
        }
        
        
        
        ref = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/users/x\(userid)x/chats/\(convo)")
        
        ref.observeEventType(.ChildAdded, withBlock: {
            snapshot in
            //            var message = snapshot.value
            
            var textView = self.chatWindow.text
            self.chatWindow.text = textView.stringByAppendingString("\((snapshot.value["name"] as? String)!): \((snapshot.value["message"] as? String)!)\n\n\n")
            self.chatWindow.scrollRangeToVisible(NSMakeRange(-3, 0))
            //            self.viewDidLayoutSubviews()
            //            print("\((snapshot.value["message"] as? String)!)\n")
            //            self.ChatWindow.text += snapshot.value["message"] as? String
            //            print(snapshot.value)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        //        let ref5 = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/conversations/")
        //        ref5.observeEventType(.Value, withBlock: {
        //            snapshot in
        //            var chat = snapshot
        //            print(chat)
        //            print("children")
        //            print(chat.childSnapshotForPath("x2xx8x").children.allObjects)
        ////            print(chat["x2xx8x"]!!["-KI0YPMy3hGWCcCNcr-U"]!!["message"])
        ////            let firstKey = Array(chat.keys)[0]
        //        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func sendMessageButton(sender: UIButton) {
        var someDict:[String:String] = ["name": "\(name)", "message": textField.text!]
        let ref2 = ref.childByAutoId()
        ref2.setValue(someDict)
        let ref7 = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/users/x\(contact)x/chats/\(convo)")
        let ref8 = ref7.childByAutoId()
        ref8.setValue(someDict)
        
        print("Button Clicked")
        textField.text = ""
        
        
        
        //        let ref3 = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/users/messages/xx\(contact)xx")
        //        let ref4 = ref3.childByAutoId()
        //        ref4.setValue("New Message")
    }
    
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        self.ChatWindow.setContentOffset(CGPointZero, animated: false)
    //    }
}