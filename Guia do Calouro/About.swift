//
//  About.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 27/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class About {
//    "id": 1,
//    "name": "Guia do Calouro",
//    "version": "2.0",
//    "body": "\u003Cp\u003ETEste\u003C\/p\u003E\r\n",
//    "email": "admin@admin.com"

    var id:Int?
    var name: String?
    var version: Int?
    var body:String?
    var email:String?
    
    var array = [ About ]()
    
    init(id:Int, name:String, version: Int, body:String, email:String ) {
        self.id = id
        self.name = name
        self.version = version
        self.body = body
        self.email = email
    }
    
    init(array: [String: AnyObject]){
        id = array["id"] as? Int
        name = array["name"] as? String
        version = array["version"] as? Int
        body = array["body"] as? String
        email = array["email"] as? String
    }
}
