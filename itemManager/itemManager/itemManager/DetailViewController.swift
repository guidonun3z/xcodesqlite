//
//  DetailViewController.swift
//  itemManager
//
//  Created by Adem Hadrovic on 5/6/18.
//  Copyright © 2018 UAreIT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    
    //itemDescription
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = itemNameLabel {
                label.text = detail.itemName
            }
            if let label = itemQuantityLabel {
                label.text = detail.itemQuantity
            }
            if let label = detailDescriptionLabel {
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

