//
//  MasterViewController.swift
//  masterDetailApp
//
//  Created by Guido Nuñez Apaza on 5/10/19.
//  Copyright © 2019 SSSST. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    //objects will become an array of objects of the item class
    //var objects = [Item]() // this is to be removed once storage is implemented
    
    //item counter just so we can see the different items generated
    var count = 0;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        
        //Dase de datos
        let base2 = DBManager(nombre_base: "test.sqlite")
        base2.crearDB()
        //base2.insertarDB()
        base2.mostrarDB()
        //base2.borrar_fila_en_datosTABLE(id2: 2)
        //base2.actualizar_imagen_en_datosTABLE(id2: 2, imagen: "www.google.pe")
        //base2.insertar_en_paisTABLE(nombre: "Canada", imagen: "www.google.ca")
        //base2.insertar_en_datosTABLE(id: 2, capital: "Vacouver", imagen: "www.google.ca")
        
        //base2.actualizar_imagen_en_paisTABLE(id2: 1, imagen: "www.google.ar")
        
        //base2.borrar_fila_en_paisTABLE(id2: 2)
        //base2.insertarDB()
        //base2.mostrarDB()
        
        

        //To Do: change addButton action to simply segue to add item view
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //we don't really need this once the add item view is implemented...
    @objc
    func insertNewObject(_ sender: Any) {
        
        /*
        //make new item for testing
        let newItem = Item(itemName: "Test", itemQuantity: "\(count)",itemDescription: "This is a test Item of item \(count)")
        
        count += 1
        
        //Storage.shared.objects.append(newItem) // uncomment when we implement storage
        Storage.shared.objects.insert(newItem, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
         */
        
        performSegue(withIdentifier: "showAddItem", sender: Any?.self)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = Storage.shared.objects[indexPath.row] //no need for unwrapping or casting. we always expect items
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                controller.detailItem = object
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        

        
        
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return Storage.shared.objects.count //uncomment when we implement storage
        return Storage.shared.objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? itemUITableViewCell
        
        //for now, we will set the UI element directly
        //we will also store the properties to each cell locally (for now)
        
        //stored properties
        cell?.itemName = Storage.shared.objects[indexPath.row].itemName
        cell?.itemQuantity = Storage.shared.objects[indexPath.row].itemQuantity
        cell?.itemDescription = Storage.shared.objects[indexPath.row].itemDescription
        
        //UI Label Text
        cell?.itemNameLabel.text = Storage.shared.objects[indexPath.row].itemName
        cell?.itemQuantityLabel.text = Storage.shared.objects[indexPath.row].itemQuantity
        
        return cell!
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Storage.shared.objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

