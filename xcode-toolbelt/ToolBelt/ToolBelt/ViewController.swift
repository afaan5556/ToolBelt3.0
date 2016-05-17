//
//  MainPage.swift
//  ToolBelt
//
//  Created by Peter Kang on 5/14/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//
import UIKit
import Alamofire
class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        
        
        if let token = FBSDKAccessToken.currentAccessToken(){
            fetchProfile()
            super.performSegueWithIdentifier("mainMenu", sender: self)
        }
        
        
    }
    
    func fetchProfile(){
        
        
        var email = ""
        var first_name = ""
        var last_name = ""
        var image = ""
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            
            email = (result["email"] as? String)!
            first_name = (result["first_name"] as? String)!
            last_name = (result["last_name"] as? String)!
            image = (result["picture"]!!["data"]!!["url"] as? String)!
            
            Alamofire.request(.POST, "https://afternoon-bayou-17340.herokuapp.com/users", parameters: ["email": email, "first_name": first_name, "last_name": last_name, "image": image]).responseJSON { response in
                if let JSON = response.result.value {
                    print(JSON)
                    let user_id = (JSON["user_id"] as! Int)
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(user_id, forKey: "toolBeltUserID")
                    defaults.synchronize()
                }
            }
        }
    }
    
    func loadDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        print(defaults.objectForKey("toolBeltUserID") as! Int)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        //        print("completed login")
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    
}