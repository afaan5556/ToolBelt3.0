//
//  RatingsPageController.swift
//  ToolBelt
//
//  Created by Emmet Susslin on 5/18/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//
import UIKit
import Alamofire
class RatingsPageController: UIViewController {
    
    var ratee = Int()
    
    @IBOutlet var ratingView: RatingControl!
    
    @IBAction func submitRating(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        print(userid)
        print(ratee)
        print(ratingView.rating)
        Alamofire.request(.POST, "https://afternoon-bayou-17340.herokuapp.com/ratings", parameters: ["rater_id": userid, "ratee_id": ratee, "rating": ratingView.rating])

        performSegueWithIdentifier("returnHomeFromRating", sender: sender)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "flagUserSegue") {
            let destination : FlagUserController = segue.destinationViewController as! FlagUserController
            destination.flagee = ratee
            
        }
    }
    
}