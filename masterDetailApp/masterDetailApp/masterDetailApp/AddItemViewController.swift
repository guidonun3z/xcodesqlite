//
//  AddItemViewController.swift
//  masterDetailApp
//
//  Created by Guido Nuñez Apaza on 5/10/19.
//  Copyright © 2019 SSSST. All rights reserved.
//


import UIKit


class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var itemNameInput:UITextField!
    @IBOutlet weak var itemQuantInput:UITextField!
    @IBOutlet weak var itemDescriptionInput: UITextView!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func submitNewItemForm(_ sender: Any) {
    
    
    //might add later: Overwriting records with the same ID
    
        let newItemName = itemNameInput.text!
        let newItemQuantity = itemQuantInput.text!
        let newItemDescription = itemDescriptionInput.text!
    
        let newItem = Item(itemName: newItemName, itemQuantity: newItemQuantity , itemDescription: newItemDescription)
    
        Storage.shared.objects.append(newItem)

    
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        itemQuantInput.delegate = self
       
        //doneButton.isEnabled = false

        itemQuantInput.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        itemNameInput.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        //itemDescriptionInput.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
    }
    
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let name = itemNameInput.text, !name.isEmpty,
            let quant = itemQuantInput.text, !quant.isEmpty
            else {
               // self.doneButton.isEnabled = false
                return
        }
        //doneButton.isEnabled = true
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}
