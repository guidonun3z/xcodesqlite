//
//  DBManager.swift
//  masterDetailApp
//
//  Created by Guido Nuñez Apaza on 5/10/19.
//  Copyright © 2019 SSSST. All rights reserved.
//

import Foundation
import SQLite3


class DBManager: NSObject {
    
    var nombre_db:String = " "
    
    internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    init(nombre_base:String) {
        self.nombre_db = nombre_base
    }
    
    var db: OpaquePointer?
    var statement: OpaquePointer?
    
    func crearDB(){
        //creando la DB
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(nombre_db)
        print(fileURL)
        
        // open database
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        else {
            print("exito abriendo bd!")
        }
        
        // creando la tabla
        
        if sqlite3_exec(db, "create table if not exists 'pais' ('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'nombre'TEXT,'imagen'TEXT) ", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
            
        else {
            print("exito creando la tabla pais!")
        }
        
        if sqlite3_exec(db, "create table if not exists 'datos' ('id'INTEGER NOT NULL,'capital' TEXT,'imagen' TEXT, PRIMARY KEY('id'),FOREIGN KEY('id') REFERENCES 'pais'('id'));", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
            
        else {
            print("exito creando la tabla datos!")
        }
        
        
    }
    func insertarDB()
    {
        
        //preparando
        if sqlite3_prepare_v2(db, "insert into pais (nombre,imagen) values (?,?)", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        //insertando
        
        if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        if sqlite3_bind_text(statement, 1,"argentina", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        
        if sqlite3_bind_text(statement, 2,"http://guidonunez.com/sqlite/argentina.jpg", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting null: \(errmsg)")
        }
        else{
            print("se inserto correctamente")
        }
        //finalizando
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil
        
        //insertando en datos
        //preparando 2
        
        if sqlite3_prepare_v2(db, "insert into datos (id,capital,imagen) values (?,?,?)", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        //insertando
        
        if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        if sqlite3_bind_int(statement, 1, 1) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding int null: \(errmsg)")
        }
        
        if sqlite3_bind_text(statement, 2,"Buenos Aires", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        if sqlite3_bind_text(statement, 3,"http://guidonunez.com/sqlite/argentina.jpg", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting null: \(errmsg)")
        }
        else{
            print("se inserto correctamente")
        }
        //finalizando
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil
        
        self.mostrarDB2()
        
    }
    func mostrarDB()
    {
        var newItemQuantity = 0
        var newItemName = ""
        var newItemDescription = ""
        let consulta  = "select id, nombre, imagen from pais"
        
        
        if sqlite3_prepare_v2(db, consulta, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        print("el contenido de la tabla es: ")
        while sqlite3_step(statement) == SQLITE_ROW {
            
            let id = sqlite3_column_int64(statement, 0)
            print("id = \(id); ", terminator: "")
            
            newItemQuantity = Int(id)
            
            
            if let cString = sqlite3_column_text(statement, 1) {
                let nombre = String(cString: cString)
                print("nombre = \(nombre)")
                newItemName = nombre
            } else {
                print("name not found")
            }
            
            if let cadena = sqlite3_column_text(statement, 2){
                let imagen = String(cString:cadena)
                print("imagen =  \(imagen)")
                newItemDescription = imagen
            }else {
                print("name not found")
            }
            
            let newItem = Item(itemName: newItemName, itemQuantity: "\(newItemQuantity)" , itemDescription: newItemDescription)
            Storage.shared.objects.append(newItem)
            
            
        }
        
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil
        
        // closing database
        
        if sqlite3_close(db) != SQLITE_OK {
            print("error closing database")
        }
        
        db = nil
    }
    func mostrarDB2()
    {
        
        let consulta  = "select pais.id, pais.nombre, pais.imagen, datos.id,datos.capital,datos.imagen  from pais INNER JOIN datos ON datos.id = pais.id "
        
        if sqlite3_prepare_v2(db, consulta, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        print("el contenido de la tabla es: ")
        while sqlite3_step(statement) == SQLITE_ROW {
            
            //pais
            let idpais = sqlite3_column_int64(statement, 0)
            print("id = \(idpais); ", terminator: "")
            
            if let cString = sqlite3_column_text(statement, 1) {
                let nombrepais = String(cString: cString)
                print("nombre del pais = \(nombrepais)")
            } else {
                //print("name not found")
            }
            
            if let cadena = sqlite3_column_text(statement, 2){
                let imagenpais = String(cString:cadena)
                print("imagen pais =  \(imagenpais)")
            }
            
            //datos
            let iddatos = sqlite3_column_int64(statement, 3)
            print("id pais - dato = \(iddatos); ", terminator: "")
            
            if let cString2 = sqlite3_column_text(statement, 4) {
                let nombrepais = String(cString: cString2)
                print("capital = \(nombrepais)")
            } else {
                //print("name not found")
            }
            
            if let cadena2 = sqlite3_column_text(statement, 5){
                let imagendatos = String(cString:cadena2)
                print("imagen dato =  \(imagendatos)")
            }
            
            
        }
        
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil
        
        // closing database
        
        if sqlite3_close(db) != SQLITE_OK {
            print("error closing database")
        }
        
        db = nil
    }
    //insertar en pais
    
    func insertar_en_paisTABLE(nombre : String,imagen: String )
    {
        
        //preparando
        if sqlite3_prepare_v2(db, "insert into pais (nombre,imagen) values (?,?)", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        //insertando
        
        if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        if sqlite3_bind_text(statement, 1,nombre, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        
        if sqlite3_bind_text(statement, 2,imagen, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting null: \(errmsg)")
        }
        else{
            print("se inserto correctamente")
        }
        //finalizando
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil
        
        self.mostrarDB()
        
    }
    
    func insertar_en_datosTABLE(id : Int, capital : String, imagen: String)
    {
        //preparando 2
        
        if sqlite3_prepare_v2(db, "insert into datos (id,capital,imagen) values (?,?,?)", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        //insertando
        
        if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        //1
        if sqlite3_bind_int(statement, 1, Int32(id)) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding int null: \(errmsg)")
        }
        //2
        if sqlite3_bind_text(statement, 2,capital, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        //3
        if sqlite3_bind_text(statement, 3,imagen, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting null: \(errmsg)")
        }
        else{
            print("se inserto correctamente")
        }
        //finalizando
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil
        
        self.mostrarDB()
    }
    
    
    func actualizar_imagen_en_paisTABLE(id2 : Int32,imagen: String )
    {
        //preparando
        if sqlite3_prepare_v2(db, "update pais SET imagen = ? where id == \(id2) ", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        //insertando
        
        if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        /*if sqlite3_bind_text(statement, 1,nombre, -1, SQLITE_TRANSIENT) != SQLITE_OK {
         let errmsg = String(cString: sqlite3_errmsg(db)!)
         print("failure binding null: \(errmsg)")
         }
         */
        if sqlite3_bind_text(statement,1,imagen, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting null: \(errmsg)")
        }
        else{
            print("se actualizo correctamente")
        }
        //finalizando
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil
    }
    func borrar_fila_en_paisTABLE(id2 : Int32 )
    {
        //preparando
        if sqlite3_prepare_v2(db, "delete from pais where id == \(id2) ", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing deleting: \(errmsg)")
        }
        
        //insertando
        
        if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting null: \(errmsg)")
        }
        else{
            print("se borro registro")
        }
        //finalizando
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil
    }
    
    
    func actualizar_imagen_en_datosTABLE(id2 : Int32, imagen: String)
    {
        //preparando 2
        
        if sqlite3_prepare_v2(db, "update datos SET  imagen = ? where id == \(id2) ", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        //insertando
        
        if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        //1
        if sqlite3_bind_text(statement, 1,imagen, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting null: \(errmsg)")
        }
        else{
            print("se actualizo la imagen correctamente")
        }
        //finalizando
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil
        
        
    }
    func borrar_fila_en_datosTABLE(id2 : Int32)
    {
        //preparando 2
        
        if sqlite3_prepare_v2(db, "delete from datos where id == \(id2)  ", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        //insertando
        
        if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting null: \(errmsg)")
        }
        else{
            print("se borro registro")
        }
        //finalizando
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil
        
        
    }
    
    
    
    
    
}
