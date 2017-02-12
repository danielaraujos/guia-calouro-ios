//
//  Calendar.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 10/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class Calendar{
    var id: Int?
    var name: String?
    var month_calendar_id: Int?
    
    var array = [Calendar]()
    
    init(id: Int, name:String, month_calendar_id: Int ){
        self.id = id
        self.name = name
        self.month_calendar_id = month_calendar_id
    }
    
    init(array: [String: AnyObject]) {
        id = array["id"] as? Int;
        name = array["name"] as? String;
        month_calendar_id = array["month_calendar_id"] as? Int
    }
    
}
