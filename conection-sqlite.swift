import UIKit

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
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(nombre_db)
        
        // open database
        
       
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        else {
            print("exito abriendo bd!")
        }
        
        // create table
        if sqlite3_exec(db, "create table if not exists test (id integer primary key autoincrement, name text)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
            
        else {
            print("exito creando la tabla!")
        }
        
        // insert value
        
      
       // var statement: OpaquePointer?
        
        /*if sqlite3_prepare_v2(db, "insert into test (name) values (?)", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }*/
        
       /* if sqlite3_bind_text(statement, 1, "Rene", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding foo: \(errmsg)")
        }
        
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting foo: \(errmsg)")
        }*/
        
        //***********//
        
        // reset  and  insert null value
        
      /*  if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        if sqlite3_bind_null(statement, 1) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting null: \(errmsg)")
        }
        */
        
        //*****************//
        
        /*if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        if sqlite3_bind_text(statement, 1,"http://guidonunez.com/sqlite/argentina.jpg", -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding null: \(errmsg)")
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting null: \(errmsg)")
        }*/
        //*****************//
        
        //terminamos los inserts
        
       /* if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        statement = nil*/
        
        //imprimir los ingresado
        
       /*
        if sqlite3_prepare_v2(db, "select id, name from test", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int64(statement, 0)
            print("id = \(id); ", terminator: "")
            
            if let cString = sqlite3_column_text(statement, 1) {
                let name = String(cString: cString)
                print("name = \(name)")
            } else {
                print("name not found")
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
        
        db = nil*/
    }
    func insertarDB()
    {
        
        //preparando
        if sqlite3_prepare_v2(db, "insert into test (name) values (?)", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        //insertando
        
        if sqlite3_reset(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error resetting prepared statement: \(errmsg)")
        }
        
        if sqlite3_bind_text(statement, 1,"http://guidonunez.com/sqlite/argentina.jpg", -1, SQLITE_TRANSIENT) != SQLITE_OK {
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
        /*
        if sqlite3_prepare_v2(db, "select id, name from test", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int64(statement, 0)
            print("id = \(id); ", terminator: "")
            
            if let cString = sqlite3_column_text(statement, 1) {
                let name = String(cString: cString)
                print("name = \(name)")
            } else {
                print("name not found")
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
        
        db = nil*/
    }
    func mostrarDB()
    {
        
        if sqlite3_prepare_v2(db, "select id, name from test", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int64(statement, 0)
            print("id = \(id); ", terminator: "")
            
            if let cString = sqlite3_column_text(statement, 1) {
                let name = String(cString: cString)
                print("name = \(name)")
            } else {
                print("name not found")
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


}
let base2 = DBManager(nombre_base: "prueba5.sqlite")
base2.crearDB()
base2.insertarDB()
//base2.mostrarDB()



CREATE TABLE 'pais' ('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'nombre'TEXT,'imagen'TEXT);
CREATE TABLE 'datos' ('id'INTEGER NOT NULL,'capital' TEXT,'imagen'	TEXT, PRIMARY KEY('id'),FOREIGN KEY('id') REFERENCES 'pais'('id'));




func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
 {
    if editingStyle == UITableViewCell.EditingStyle.delete {
        brainList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)

        self.tableViewHeroes.reloadData()

    }
}



//****************************************************************************//




import UIKit

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
        
        self.mostrarDB()
       
    }
    func mostrarDB()
    {
        
        if sqlite3_prepare_v2(db, "select id, nombre, imagen from pais", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        print("el contenido de la tabla es: ")
        while sqlite3_step(statement) == SQLITE_ROW {
            
            let id = sqlite3_column_int64(statement, 0)
            print("id = \(id); ", terminator: "")
            
            if let cString = sqlite3_column_text(statement, 1) {
                let nombre = String(cString: cString)
                print("nombre = \(nombre)")
            } else {
                print("name not found")
            }
            if let cadena = sqlite3_column_text(statement, 2){
                let imagen = String(cString:cadena)
                print("imagen =  \(imagen)")
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
    
    
    


}
let base2 = DBManager(nombre_base: "test2.sqlite")
base2.crearDB()

//base2.insertar_en_paisTABLE(nombre: "Canada", imagen: "www.google.ca")
//base2.insertar_en_datosTABLE(id: 2, capital: "Vacouver", imagen: "www.google.ca")

//base2.actualizar_imagen_en_paisTABLE(id2: 1, imagen: "www.google.ar")

//base2.borrar_fila_en_paisTABLE(id2: 2)
//base2.insertarDB()
//base2.mostrarDB()



////////////////////*********************************************///////////////////////****************////////////////****///////






import UIKit

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
        
        self.mostrarDB()
       
    }

    
    func mostrarDB()
    {
        
        if sqlite3_prepare_v2(db, "select id, nombre, imagen from pais", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        print("el contenido de la tabla es: ")
        while sqlite3_step(statement) == SQLITE_ROW {
            
            let id = sqlite3_column_int64(statement, 0)
            print("id = \(id); ", terminator: "")
            
            if let cString = sqlite3_column_text(statement, 1) {
                let nombre = String(cString: cString)
                print("nombre = \(nombre)")
            } else {
                print("name not found")
            }
            if let cadena = sqlite3_column_text(statement, 2){
                let imagen = String(cString:cadena)
                print("imagen =  \(imagen)")
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
    
    
    


}
let base2 = DBManager(nombre_base: "test2.sqlite")
base2.crearDB()

//base2.insertar_en_paisTABLE(nombre: "Canada", imagen: "www.google.ca")
//base2.insertar_en_datosTABLE(id: 2, capital: "Vacouver", imagen: "www.google.ca")

//base2.actualizar_imagen_en_paisTABLE(id2: 1, imagen: "www.google.ar")

//base2.borrar_fila_en_paisTABLE(id2: 2)
//base2.insertarDB()
//base2.mostrarDB()