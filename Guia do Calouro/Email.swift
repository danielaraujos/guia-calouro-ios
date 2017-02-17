//
//  Email.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 16/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class Email {
//    "id": 1,
//    "name": "Adriana Zanella Martinhago",
//    "mail": "adriana.martinhago@ufv.br",
//    "phone": "3855-9329"
    
    
    var id:Int?
    var name: String?
    var mail: String?
    var phone: String?
    
    var array = [Email]()
    
    init(id: Int, name:String, mail:String, phone:String) {
        self.id = id
        self.name = name
        self.mail = mail
        self.phone = phone
    }
    
    init(array : [String: AnyObject]) {
        id = array["id"] as? Int
        name = array["name"] as? String
        mail = array["mail"] as? String
        phone = array["phone"] as? String
    }
    
}
