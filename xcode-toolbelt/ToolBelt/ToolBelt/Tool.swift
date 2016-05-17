//
//  Tool.swift
//  ToolBelt
//
//  Created by Afaan on 5/15/16.
//  Copyright © 2016 teamToolBelt. All rights reserved.
//

import UIKit
class Tool {
    var title: String
    var description: String
    var ownerId: Int
    
    // MARK: Initialization
    
    init(title: String, description: String, ownerId: Int) {
        
        // Initialize tool with title and description
        self.title = title
        self.description = description
        self.ownerId = ownerId
        
    }
}
