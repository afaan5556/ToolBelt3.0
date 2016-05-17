//
//  ChatController.swift
//  ToolBelt
//
//  Created by Afaan on 5/16/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit
import Firebase

class ChatController: UIViewController {
    
    
    @IBOutlet var chatWindow: UITextView!

    @IBOutlet var textField: UITextField!
    
    var ref = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/test1")
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "flagUserSegue") {
//            let destination : FlagUserController = segue.destinationViewController as! FlagUserController
//            destination.flagee = 2
//            
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        var someDict:[String:String] = ["name": "name", "message": textField.text!]
        let ref2 = ref.childByAutoId()
        ref2.setValue(someDict)
        print("Button Clicked")
        textField.text = ""
    }
    
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        self.ChatWindow.setContentOffset(CGPointZero, animated: false)
    //    }
}
