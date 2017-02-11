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
    var image: UIImage?
    var credits: String?
    var body:String?
    
    let array = [String]()
    
    
    init(id: Int, name:String, sub_name:String, image:UIImage, credits:String, body:String){
        self.id = id;
        self.name = name;
        self.sub_name = sub_name;
        self.image = image
        self.credits = credits;
        self.body = body;
    }
    
    init(array:[String: AnyObject]) {
        id == array["id"] as? Int
        name = array["name"] as? String
        sub_name = array["sub_name"] as? String
        image = array["image"] as? UIImage
        credits = array["credits"] as? String
        body = array["body"] as? String
    }

}


