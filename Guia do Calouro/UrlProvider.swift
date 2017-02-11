//
//  UrlProvider.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 09/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation

class UrlProvider{
    private static let _instance = UrlProvider();
    
    static var Instance: UrlProvider{
        return _instance;
    }
    
    func lerUrl (sufix:String)-> String{
        let url = "http://localhost/Pessoal/webservicecalouro/api/v1/"
        return "\(url)\(sufix)"
    }
    
    
    let lerUrlBuilding = "http://localhost/Pessoal/webservicecalouro/webroot/uploads/building/"
    
    
}