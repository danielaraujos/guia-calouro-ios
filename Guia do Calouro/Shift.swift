//
//  Shift.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 25/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class Shift {
//    "id": 1,
//    "name": "Hor\u00e1rio da Manh\u00e3"

    var id: Int?
    var name:String?
    
    var array = [Shift]()
    
    init(id: Int,name: String) {
        self.id = id
        self.name = name
    }
    
    init(array : [String: AnyObject]) {
        id = array["id"] as? Int
        name = array["name"] as? String
    }
    
}
