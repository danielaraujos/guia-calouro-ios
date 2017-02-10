//
//  ViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 08/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        let url = UrlProvider.Instance.lerUrl(sufix: "buildings.json")
        self.CallAlomo(url: url);
        
    }
    
    
    
    
    func CallAlomo(url:String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
            
        });
    }
    
    func parseData(JSONData: Data){
        
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.mutableContainers)
            print(json)
        
        }catch{
            print(error)
        }
        
    }


    
    
    

}

