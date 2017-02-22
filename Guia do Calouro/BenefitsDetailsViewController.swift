//
//  BenefitsDetailsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 13/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class BenefitsDetailsViewController: UIViewController {
    @IBOutlet weak var imageBenefits: UIImageView!
    @IBOutlet weak var buttonInformations: UIButton!
    @IBOutlet weak var webViewText: UIWebView!

    var benefitsGet: Benefit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = benefitsGet.title!
        webViewText.loadHTMLString(benefitsGet.body!, baseURL: nil)
        
        
        Alamofire.request(UrlProvider.Instance.letImage(sufix:"\(benefitsGet.dir!)\(benefitsGet.image!)")).responseImage { response in
            if let images = response.result.value {
                self.imageBenefits.image = images
            }
        }
        
    }

    
    

   

}
