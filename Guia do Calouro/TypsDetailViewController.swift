//
//  TypsDetailViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 20/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit

class TypsDetailViewController: UIViewController {

    var typs: Type!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.typs.name
    }

}
