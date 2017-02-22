//
//  Type.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 20/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation


class Type{

    var id:Int?
    var name: String?
    var body: String?
    var name_link: String?
    var link: String?
    var category_typ_id: Int?
    
    var array = [Type]()
    
    init(id: Int, name:String, body:String, name_link:String,link:String, category_typ_id:Int) {
        self.id = id
        self.name = name
        self.body = body
        self.name_link = name_link
        self.link = link
        self.category_typ_id = category_typ_id
    }
    
    init(array : [String: AnyObject]) {
        id = array["id"] as? Int
        name = array["name"] as? String
        body = array["body"] as? String
        name_link = array["name_link"] as? String
        link = array["link"] as? String
        category_typ_id = array["category_typ_id"] as? Int
    }


}
