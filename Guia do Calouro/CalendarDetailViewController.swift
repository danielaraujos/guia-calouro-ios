//
//  CalendarDetailViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 20/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit

class CalendarDetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var calendar: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Informações"
        
        self.textView.text = calendar
    }

   
    

}
