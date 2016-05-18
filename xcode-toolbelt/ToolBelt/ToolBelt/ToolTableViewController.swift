import UIKit
import Alamofire
import MapKit
class ToolTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    // MARK - Outlets
    
    
    @IBOutlet weak var toolListSearchBar: UISearchBar!
    
    
    // MARK - Load sample tools
    
    let locationManager = CLLocationManager()
    var currentLat: CLLocationDegrees = 0.0
    var currentLong: CLLocationDegrees = 0.0
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let location = locations.last! as CLLocation
        currentLat = location.coordinate.latitude
        currentLong = location.coordinate.longitude
    }
    
    var tools = [Tool]()
    
    
    
    
    func searchBarSearchButtonClicked( searchbar: UISearchBar)
    {
        searchbar.resignFirstResponder()
        tools = []
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let userid: Int = defaults.objectForKey("toolBeltUserID") as! Int
        
        let searchTerm = String(toolListSearchBar.text!)
        
        
        Alamofire.request(.GET, "http://afternoon-bayou-17340.herokuapp.com/tools/search", parameters: ["keyword": searchTerm, "latitude": currentLat, "longitude": currentLong, "user": userid]) .responseJSON {response in
            if let JSON = response.result.value {
                print("\(JSON)")
                
                for var i = 0; i < JSON.count; i++ {
                    
                    let owner = JSON[i].objectForKey("owner")
                    let tool = JSON[i].objectForKey("tool")
                    let title = tool!["title"] as? String!
                    let ownerId = owner!["id"] as? Int!
                    let distanceToTool = JSON[i].objectForKey("distance") as! Double
                    var description: String
                    
                    if let des = tool!["description"] as?  NSNull {
                        description = ""
                    } else {
                        description = (tool!["description"] as? String!)!
                    }
                    
                    let myTool = Tool(title: title!, description: description, ownerId: ownerId!, distance: distanceToTool)
                    
                    self.tools += [myTool]
                }
                self.tableView.reloadData()
                
            } else {
                print("Sent search term, but no response")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        
        // Load the sample data.
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tools.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ToolTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ToolTableViewCell
        let tool = tools[indexPath.row]
        let distance = tool.distance
        cell.toolListTitle.text = tool.title
        cell.toolListDescription.text = tool.description
        cell.ownerId = tool.ownerId
        cell.distance.text = "\(tool.distance)mi"
        
        return cell
    }
    
    // Pass Owner ID to Chat Page
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "contactOwnerSegue",
            let destination = segue.destinationViewController as? ChatController,
            toolIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.contact = tools[toolIndex].ownerId
        }
    }
    
    func tapRowAtIndex(index:Int) {
        let rowToSelect:NSIndexPath = NSIndexPath(forRow: index, inSection: 0)
        self.tableView.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.None)
        self.tableView(self.tableView, didSelectRowAtIndexPath: rowToSelect)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("contactOwnerSegue", sender: ToolTableViewCell.self)
    }
    
    
    
}