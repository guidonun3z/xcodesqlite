//
//  DetailViewController.swift
//  masterDetailApp
//
//  Created by Guido Nuñez Apaza on 5/10/19.
//  Copyright © 2019 SSSST. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //UI Elements
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    
    //this is the itemDescriptionLabel. I didn't change name because I didn't feel like changing the referene
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
//this will dynamically change the detail view
//without the need to set the parameters during the segue
    func configureView() {
        // Update the user interface for the detail item.
        
        //check if the detail to be displayed is our proper item
        if let detail = detailItem {
            
            //assign itemName text to itemNameLabel
            if let label = itemNameLabel {
                label.text = detail.itemName
            }
            //assign itemQuantity text to itemQuantityLabel
            if let label = itemQuantityLabel{
                label.text = detail.itemQuantity
            }
            //assign itemDescription text to itemDescriptionLabel
            if let label = detailDescriptionLabel{
                label.text = detail.itemDescription
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Item? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

