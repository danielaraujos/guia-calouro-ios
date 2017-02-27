//
//  Feeding.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 27/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation


class Feeding {
//    
//    "id": 1,
//    "link": "http:\/\/www.portal.ufv.br\/crp\/?page_id=2074"

    var id: Int?
    var link: String?
    var array = [Feeding]()
    
    init(id: Int, link: String) {
        self.id = id
        self.link = link
    }
    
    init(array: [String: AnyObject]) {
        id = array["id"] as? Int
        link = array["link"] as? String
    }

}
