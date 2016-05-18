//
//  ToolTableViewCell.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//
//
//import UIKit
//
//class ToolTableViewCell: UITableViewCell {
//    
//    // MARK: Properties
//    
//    
//    @IBOutlet weak var toolListTitle: UILabel!
//    
//    
//    @IBOutlet weak var toolListDescription: UILabel!
//    
//    
//    @IBOutlet weak var toolContactOwner: UIButton!
//
//}


import UIKit
class ToolTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    
    @IBOutlet weak var toolListTitle: UILabel!
    
    
    @IBOutlet weak var toolListDescription: UILabel!
    
    
    var ownerId = Int()
    
}