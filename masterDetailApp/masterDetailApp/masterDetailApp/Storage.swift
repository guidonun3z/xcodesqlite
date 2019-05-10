//
//  Storage.swift
//  masterDetailApp
//
//  Created by Guido Nuñez Apaza on 5/10/19.
//  Copyright © 2019 SSSST. All rights reserved.
//

import Foundation


class Storage {
    static let shared: Storage = Storage()
    
    var objects : [Item]
    
    private init() {
        objects = [Item]()
    }
}
