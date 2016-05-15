//
//  ToolTableViewController.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit

class ToolTableViewController: UITableViewController {
    
    var tools = [Tool]()
    
    // Table view cells are reused and should be dequeued using a cell identifier.
    

    
    func loadSampleTools() {
        let tool1 = Tool(title: "Power drill", description: "Portable power drill with bits. Very powerful and lightweight.")
        let tool2 = Tool(title: "Table saw", description: "Stationary table saw in my garage. Safe and smooth.")
        let tool3 = Tool(title: "Jack Hammer", description: "Poor-mans jack hammer. Not heavy duty but does the job.")
        let tool4 = Tool(title: "Full toolkit", description: "No power tools, but my tookit has all hammers, nails, screwdrivers stc for everyday DIY jobs.")
        
        tools += [tool1, tool2, tool3, tool4]
        
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
        return tools.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ToolTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ToolTableViewCell
        let tool = tools[indexPath.row]
        
        cell.toolListTitle.text = tool.title
        cell.toolListDescription.text = tool.description
        
        return cell
    }
    
    
    
    

}
