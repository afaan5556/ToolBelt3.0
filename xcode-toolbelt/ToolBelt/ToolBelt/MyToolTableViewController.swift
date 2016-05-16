//
//  MyToolTableViewController.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit


class MyToolTableViewController: UITableViewController {
    
    var mytools = [Tool]()
    
    // Table view cells are reused and should be dequeued using a cell identifier.
    
    
    
    func loadSampleTools() {
        let mytool1 = Tool(title: "Power drill", description: "Portable power drill with bits. Very powerful and lightweight.")
        let mytool2 = Tool(title: "Table saw", description: "Stationary table saw in my garage. Safe and smooth.")
        let mytool3 = Tool(title: "Jack Hammer", description: "Poor-mans jack hammer. Not heavy duty but does the job.")
        let mytool4 = Tool(title: "Full toolkit", description: "No power tools, but my tookit has all hammers, nails, screwdrivers stc for everyday DIY jobs.")
        
        mytools += [mytool1, mytool2, mytool3, mytool4]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Load the sample data.
        loadSampleTools()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mytools.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ToolTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ToolTableViewCell
        let tool = mytools[indexPath.row]
        
        cell.toolListTitle.text = tool.title
        cell.toolListDescription.text = tool.description
        
        return cell
    }

    
    

}
