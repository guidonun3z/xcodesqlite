//
//  AddItemViewController.swift
//  itemManager
//
//  Created by Adem Hadrovic on 5/6/18.
//  Copyright © 2018 UAreIT. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController,  UITextFieldDelegate{
    
    @IBOutlet weak var itemNameInput: UITextField!
    @IBOutlet weak var itemQuantInput: UITextField!
    @IBOutlet weak var itemDescInput: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    @objc
    @IBAction func addItem() -> Void {
        
        let newItemName = itemNameInput.text!
        let newItemQuant = itemQuantInput.text!
        let newItemDesc = itemDescInput.text!
        
        let newItem = Item(itemName: newItemName, itemQuantity: newItemQuant, itemDescription: newItemDesc)
        
        Storage.shared.objects.append(newItem)
        performSegue(withIdentifier: "backToTable", sender: self)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        itemQuantInput.delegate = self
        
        doneButton.isEnabled = false
        
        itemQuantInput.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        itemNameInput.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        
        return allowedCharacters.isSuperset(of: characterSet)
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
                self.doneButton.isEnabled = false
                return
        }
        doneButton.isEnabled = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
