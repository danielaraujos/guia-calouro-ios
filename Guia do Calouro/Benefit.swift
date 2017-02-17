//
//  Benefit.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 11/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import Foundation
import UIKit

class Benefit{
    var id: Int?
    var title : String?
    var body: String?
    var link: String?
    var image:String?
    var sub_title: String?
    var dir: String?
    
    var array = [Benefit]()
    
    init(id:Int, title:String, body:String,link:String, image:String, sub_title: String, dir:String){
        self.id = id;
        self.title = title;
        self.body = body
        self.link = link;
        self.image = image
        self.sub_title = sub_title
        self.dir = dir
    }
    
    
    init(array:[String: AnyObject]){
        id = array["id"] as? Int
        title = array["title"] as? String
        body = array["body"] as? String
        link = array["link"] as? String
        image = array["image"] as? String
        dir = array["dir"] as? String
        sub_title = array["sub_title"] as? String
        
    }



}


//
//"id": 1,
//"title": "Aux\u00edlio Moradia",
//"body": "O Programa Aux\u00edlio Moradia tem por objetivo viabilizar a perman\u00eancia de estudantes matriculados nos Cursos de Gradua\u00e7\u00e3o da Universidade Federal de Vi\u00e7osa - (UFV-CRP) em Rio Parana\u00edba, em comprovada situa\u00e7\u00e3o de vulnerabilidade econ\u00f4mica, assegurando-lhes aux\u00edlio institucional para complementa\u00e7\u00e3o de despesas com moradia e alimenta\u00e7\u00e3o durante todo o per\u00edodo do curso ou enquanto persistir a mesma situa\u00e7\u00e3o.\r\nImportante!\r\nA vincula\u00e7\u00e3o dos estudantes ao Programa Aux\u00edlio Moradia n\u00e3o os impede de receber, por m\u00e9rito, qualquer uma das bolsas dos diversos programas da UFV, de ag\u00eancias de fomento ou de empresas.\r\n",
//"link": "#",
//"image": "",
//"dir": "uploads\/benefits\/"
