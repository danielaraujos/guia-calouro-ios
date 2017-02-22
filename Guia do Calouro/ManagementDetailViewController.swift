//
//  ManagementDetailViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 21/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit

class ManagementDetailViewController: UIViewController {

    var conteudo: Management!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.conteudo.function!
    }

    


}
