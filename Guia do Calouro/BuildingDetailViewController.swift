//
//  BuildingDetailViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 10/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class BuildingDetailViewController: UIViewController {
    @IBOutlet weak var imagemBuilding: UIImageView!
    @IBOutlet weak var lblCreditos: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
   
    
    @IBOutlet weak var webViewText: UIWebView!

    var buildingGet: Building!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = buildingGet.sub_name!
        lblCreditos.text = "Créditos: \(buildingGet.credits!)"
        webViewText.loadHTMLString(buildingGet.body!, baseURL: nil)
        self.callImage()
        
        let fab = KCFloatingActionButton()
        fab.addItem("Localização", icon: UIImage(named: "icMap")!)
        
        fab.buttonColor = UIColor.red
        fab.plusColor = UIColor.white
        self.view.addSubview(fab)
    }
    
    
    func callImage(){
        Alamofire.request(UrlProvider.Instance.letImage(sufix:"\(buildingGet.dir!)\(buildingGet.image!)")).responseImage { response in
            if let imagem = response.result.value {
                self.imagemBuilding.image = imagem
            }
        }
    }
    
}
