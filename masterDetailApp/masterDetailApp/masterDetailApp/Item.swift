//
//  Item.swift
//  masterDetailApp
//
//  Created by Guido Nuñez Apaza on 5/10/19.
//  Copyright © 2019 SSSST. All rights reserved.
//

import Foundation

class Item {
    let itemName: String
    let itemQuantity: String
    let itemDescription: String
    
    init(itemName: String, itemQuantity:String, itemDescription:String) {
        self.itemName = itemName
        
        //the input is an INT, but since this value will be in a label, convert to string
        //just interlope the integer into a string
        self.itemQuantity =  "\(itemQuantity)"
        
        self.itemDescription = itemDescription
    }
}
