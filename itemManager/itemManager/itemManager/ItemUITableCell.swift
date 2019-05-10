//
//  ItemUITableCell.swift
//  itemManager
//
//  Created by Adem Hadrovic on 5/6/18.
//  Copyright © 2018 UAreIT. All rights reserved.
//

import UIKit

class ItemUITableCell: UITableViewCell {
    
    var itemName: String = ""
    var itemQuantity: String = ""
    var itemDescription: String = ""
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    
}


