//
//  CManagement.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 20/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class CManagement {

//    
//    "id": 1,
//    "name": "\u00d3rg\u00e3os T\u00e9cnicos-Administrativo"

    
    var id: Int?
    var name: String?
    
    var array = [CManagement]()
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
    
    init(array : [String: AnyObject]) {
        id = array["id"] as? Int
        name = array["name"] as? String
    }
}
