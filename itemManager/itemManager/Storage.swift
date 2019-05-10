//
//  Storage.swift
//  itemManager
//
//  Created by Adem Hadrovic on 5/6/18.
//  Copyright © 2018 UAreIT. All rights reserved.
//

import Foundation


class Storage {
    static let shared: Storage = Storage()
    
    var objects: [Item]
    
    private init(){
        objects = [Item]()
    }
}
