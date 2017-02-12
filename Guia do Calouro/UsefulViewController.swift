//
//  UsefulViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 12/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit

class UsefulViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSlideMenuButton()
        
        self.title = "Utilidades"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
