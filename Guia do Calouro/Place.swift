//
//  Place.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 25/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class Place {
//    
//    "id": 1,
//    "title": "Ponto 1",
//    "body": "\u003Cp\u003ERua Teste\u003C\/p\u003E\r\n"


    var id: Int?
    var title:String?
    var body: String?
    
    var array = [Shift]()
    
    init(id: Int,title: String, body:String) {
        self.id = id
        self.title = title
        self.body = body
    }
    
    init(array : [String: AnyObject]) {
        id = array["id"] as? Int
        title = array["title"] as? String
        body = array["body"] as? String
    }

}
