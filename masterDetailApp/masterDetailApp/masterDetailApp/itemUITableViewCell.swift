//
//  itemUITableViewCell.swift
//  masterDetailApp
//
//  Created by Guido Nuñez Apaza on 5/10/19.
//  Copyright © 2019 SSSST. All rights reserved.
//

import UIKit

class itemUITableViewCell: UITableViewCell{
    
    
    //To be shown in table - UI items
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    
    //to be stored (TO DO: create storage Class)
    var itemName: String = ""
    var itemQuantity: String = ""
    var itemDescription: String = ""
    
    
    //this isn't really need, I think
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //this isn't really need, I think
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //no need for viewDidLoad() because this is only a part of the view
    
}
