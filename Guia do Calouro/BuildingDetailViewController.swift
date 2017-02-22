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
    
    @IBOutlet weak var textView: UITextView!

    var buildingGet: Building!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = buildingGet.sub_name!
        self.textView.text = buildingGet.body!
        self.callImage()
    }
    
    
    func callImage(){
        Alamofire.request(UrlProvider.Instance.letImage(sufix:"\(buildingGet.dir!)\(buildingGet.image!)")).responseImage { response in
            if let imagem = response.result.value {
                self.imagemBuilding.image = imagem
            }
        }
    }
    
}
