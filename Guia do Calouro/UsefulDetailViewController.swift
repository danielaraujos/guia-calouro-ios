//
//  UsefulDetailViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 16/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import  Alamofire
import SVProgressHUD

class UsefulDetailViewController: UIViewController {

    
    var telephone: Telephone!
    var email: Email!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.telephone != nil{
            self.title = self.telephone.name
        }
        
        if self.email != nil{
            self.title = self.email.name
        }
    }
}
