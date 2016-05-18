
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
        var convo = "x\(arrayOfUsers[0])xx\(arrayOfUsers[1])"
        
        Alamofire.request(.GET, "https://afternoon-bayou-17340.herokuapp.com/users/\(userid)") .responseJSON { response in
            //            Alamofire.request(.GET, "http://localhost:3000/users/\(userid)") .responseJSON { response in
            
            if let JSON = response.result.value {
                print("\(JSON["first_name"])")
                self.name = (JSON["first_name"] as? String)!
                
                
            }
            
        }
        
        
        
        ref = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/conversations/\(convo)")
        
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func sendMessageButton(sender: UIButton) {
        var someDict:[String:String] = ["name": "\(name)", "message": textField.text!]
        let ref2 = ref.childByAutoId()
        ref2.setValue(someDict)
        print("Button Clicked")
        textField.text = ""
        
        let ref3 = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/users/messages/xx\(contact)xx")
        let ref4 = ref3.childByAutoId()
        ref4.setValue("New Message")
    }
    
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        self.ChatWindow.setContentOffset(CGPointZero, animated: false)
    //    }
}




























////
////  ChatController.swift
////  ToolBelt
////
////  Created by Afaan on 5/16/16.
////  Copyright © 2016 teamToolBelt. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//class ChatController: UIViewController {
//    
//    
//    @IBOutlet var chatWindow: UITextView!
//
//    @IBOutlet var textField: UITextField!
//    
//    var ref = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/test1")
//    
////    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////        if (segue.identifier == "flagUserSegue") {
////            let destination : FlagUserController = segue.destinationViewController as! FlagUserController
////            destination.flagee = 2
////            
////        }
////    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        ref.observeEventType(.ChildAdded, withBlock: {
//            snapshot in
//            //            var message = snapshot.value
//            
//            var textView = self.chatWindow.text
//            self.chatWindow.text = textView.stringByAppendingString("\((snapshot.value["name"] as? String)!): \((snapshot.value["message"] as? String)!)\n\n\n")
//            self.chatWindow.scrollRangeToVisible(NSMakeRange(-3, 0))
//            //            self.viewDidLayoutSubviews()
//            //            print("\((snapshot.value["message"] as? String)!)\n")
//            //            self.ChatWindow.text += snapshot.value["message"] as? String
//            //            print(snapshot.value)
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    
//    @IBAction func sendMessageButton(sender: UIButton) {
//        var someDict:[String:String] = ["name": "name", "message": textField.text!]
//        let ref2 = ref.childByAutoId()
//        ref2.setValue(someDict)
//        print("Button Clicked")
//        textField.text = ""
//    }
//    
//    
//    //    override func viewDidLayoutSubviews() {
//    //        super.viewDidLayoutSubviews()
//    //        self.ChatWindow.setContentOffset(CGPointZero, animated: false)
//    //    }
//}
