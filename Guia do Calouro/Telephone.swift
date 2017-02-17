
//
//  Telephones.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 16/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class Telephone {
//    "id": 1,
//    "name": "Diretoria Geral",
//    "sector": "Campus UFV",
//    "phone": "3855-9316"

    
    var id:Int?
    var name: String?
    var sector: String?
    var phone: String?
    
    var array = [Telephone]()
    
    init(id: Int, name:String, sector:String, phone:String) {
        self.id = id
        self.name = name
        self.sector = sector
        self.phone = phone
    }
    
    init(array:[String: AnyObject]){
        id = array["id"] as? Int
        name = array["name"] as? String
        sector = array["sector"] as? String
        phone = array["phone"] as? String
    }
    
}
