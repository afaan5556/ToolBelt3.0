import UIKit
import Firebase
import Alamofire
class ChatController: UIViewController {
    
    
    @IBOutlet var chatWindow: UITextView!
    
    @IBOutlet var textField: UITextField!

    
    @IBOutlet var chatName: UILabel!
    
    @IBOutlet var ratingLabel: UILabel!
    
    var contact = Int()
    var name = String()
    var convo = String()
    
    
    var ref = Firebase()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "rateSegue") {
            let destination : RatingsPageController = segue.destinationViewController as! RatingsPageController
            destination.ratee = contact
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatWindow.editable = false
        
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        var arrayOfUsers: [String] = ["\(userid)","\(contact)"]
        arrayOfUsers = arrayOfUsers.sort()
        convo = "x\(arrayOfUsers[0])xx\(arrayOfUsers[1])x"
        
        
        
        for var i = 0; i < arrayOfUsers.count; i += 1 {
            Alamofire.request(.GET, "https://afternoon-bayou-17340.herokuapp.com/users/\(arrayOfUsers[i])") .responseJSON { response in
                
                if let JSON = response.result.value {
                    if userid == JSON["id"] as! Int{
                        self.name = (JSON["first_name"] as? String)!
                    }
                    if self.contact == JSON["id"] as! Int{
                        print("\(JSON)")
                        print("hey")
                        var firstName = (JSON["first_name"] as? String)!
                        let rating = JSON["rating"] as! Int
                        print(rating)
                        self.chatName.text = "Contact \(firstName)"
                        self.ratingLabel.text = "\(rating)"
                    }
                }
                
            }
        }
        
        
        
        ref = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/users/x\(userid)x/chats/\(convo)")
        
        ref.observeEventType(.ChildAdded, withBlock: {
            snapshot in
            //            var message = snapshot.value
            
            var textView = self.chatWindow.text
            self.chatWindow.text = textView.stringByAppendingString("\((snapshot.value["name"] as? String)!): \((snapshot.value["message"] as? String)!)\n\n\n")
            self.chatWindow.scrollRangeToVisible(NSMakeRange(-3, 0))
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
        let ref7 = Firebase(url: "https://shining-inferno-8243.firebaseio.com/toolbelt/users/x\(contact)x/chats/\(convo)")
        let ref8 = ref7.childByAutoId()
        ref8.setValue(someDict)
        
        print("Button Clicked")
        textField.text = ""
        
        
    }
    
    
}