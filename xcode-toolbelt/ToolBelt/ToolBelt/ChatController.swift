//
//  ChatController.swift
//  ToolBelt
//
//  Created by Afaan on 5/16/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit


class ChatController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "flagUserSegue") {
            let destination : FlagUserController = segue.destinationViewController as! FlagUserController
             destination.flagee = 2
            
        }
    }
    
    
    
    

}
