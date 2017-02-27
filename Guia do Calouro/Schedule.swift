//
//  Schedule.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 25/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class Schedule {
//
//    "id": 1,
//    "ida": "7:30 - 07:50",
//    "intervalo": "09:30 - 10-00",
//    "volta": "11:30",
//    "shifts_id": 1
    
    
    var id: Int?
    var name: String?
    var ida:String?
    var intervalo: String?
    var volta: String?
    var shifts_id : Int?
    
    var array = [Shift]()
    
    init(id: Int, name:String, shifts_id: Int) {
        self.id = id
        self.name = name
        self.shifts_id = shifts_id
    }
    
    init(id: Int,ida: String, intervalo: String, volta:String, shifts_id: Int) {
        self.id = id
        self.ida = ida
        self.intervalo = intervalo
        self.volta = volta
        self.shifts_id = shifts_id
    }
    
    init(array : [String: AnyObject]) {
        id = array["id"] as? Int
        name = array["name"] as? String
        ida = array["ida"] as? String
        volta = array["intervalo"] as? String
        intervalo = array["volta"] as? String
        shifts_id = array["shifts_id"] as? Int
    }

}
