//
//  TypsDetailViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 20/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit


class TypsDetailViewController: UIViewController {

    @IBOutlet weak var webViewTexto: UIWebView!
    var typs: Type!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.typs.name
        webViewTexto.loadHTMLString(typs.body!, baseURL: nil)
        
        if (self.typs.link != "" ){
            let fab = KCFloatingActionButton()
            fab.addItem("Saiba Mais", icon: UIImage(named: "icShare")!, handler: { item in
                self.openUrl(url: self.typs.link!)
                fab.close()
            })
            fab.buttonColor = UIColor.red
            fab.plusColor = UIColor.white
            self.view.addSubview(fab)
        }
        
        
        
    }
    
    func openUrl(url: String){
        let websiteAddress = NSURL(string: url)
        UIApplication.shared.openURL(websiteAddress! as URL)
        print("Clicando")
    }


}
