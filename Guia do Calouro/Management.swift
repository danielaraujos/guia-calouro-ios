//
//  Management.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 20/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class Management {

//    {
//    "managements": [
//    {
//    "id": 1,
//    "function": "Diretor",
//    "name": "Frederico Garcia Pinto",
//    "room": "-",
//    "email": "frederico.pinto@ufv.br",
//    "phone": "38551647",
//    "category_management_id": 1
//    }
//    ]
//    }

    var id: Int?
    var function: String?
    var name: String?
    var room: String?
    var email: String?
    var phone:String?
    var category_management_id: Int?
    
    var array = [Management]()
    
    init(id: Int, function: String, name: String, room:String, email:String, phone: String, category_management_id: Int) {
        
        self.id = id
        self.function = function
        self.name = name
        self.room = room
        self.email = email
        self.phone = phone
        self.category_management_id = category_management_id
    }
    
    
    init(array : [String: AnyObject]) {
        id = array["id"] as? Int
        function = array["function"] as? String
        name = array["name"] as? String
        room = array["room"] as? String
        email = array["email"] as? String
        phone = array["phone"] as? String
        category_management_id = array["category_management_id"] as? Int
    }


}
