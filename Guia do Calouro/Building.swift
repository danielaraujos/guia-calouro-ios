//
//  building.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 10/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation
import UIKit

class Building {
    var id: Int?
    var name: String?
    var sub_name: String?
    var dir: String?
    var image: String?
    var credits: String?
    var body:String?
    var latitude :String?
    var longitude: String?
    
    let array = [String]()
    
    
    init(id: Int, name:String, sub_name:String, dir:String, image:String, credits:String, body:String,latitude: String, longitude: String){
        self.id = id;
        self.name = name;
        self.sub_name = sub_name;
        self.dir = dir;
        self.image = image
        self.credits = credits;
        self.body = body;
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(array:[String: AnyObject]) {
        id = array["id"] as? Int
        name = array["name"] as? String
        dir = array["dir"] as? String
        sub_name = array["sub_name"] as? String
        image = array["image"] as? String
        credits = array["credits"] as? String
        body = array["body"] as? String
        latitude = array["latitude"] as? String
        longitude = array["longitude"] as? String
    }

}


