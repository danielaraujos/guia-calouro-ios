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
        //let url = "http://danielaraujos.com/webservicecalouros/api/v1/"
        return "\(url)\(sufix)"
    }
    
    
    func letImage(sufix:String)-> String{
        let url = "http://localhost/Pessoal/webservicecalouro/img/"
        return "\(url)\(sufix)"
    }
    
    
}
