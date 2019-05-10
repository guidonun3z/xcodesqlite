//
//  Item.swift
//  itemManager
//
//  Created by Adem Hadrovic on 5/6/18.
//  Copyright © 2018 UAreIT. All rights reserved.
//

import Foundation

class Item{
    var itemName:String
    var itemQuantity:String
    var itemDescription:String
    
    init(itemName:String,itemQuantity:String,itemDescription:String) {
        self.itemName = itemName
        self.itemQuantity = itemQuantity
        self.itemDescription = itemDescription
    }
    
}
