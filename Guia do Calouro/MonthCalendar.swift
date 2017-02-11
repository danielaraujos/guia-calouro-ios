//
//  File.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 10/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class MonthCalendar{
    var id:Int?
    var name: String?
    var array = [MonthCalendar]()
    
    init(id: Int, name:String) {
        self.id = id;
        self.name = name
    }
    
    init(array:[String: AnyObject]) {
        id = array["id"] as? Int;
        name = array["name"] as? String
    }

}
