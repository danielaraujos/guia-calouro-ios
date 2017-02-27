//
//  FeedingViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 12/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class FeedingViewController: BaseViewController {
    
    var feedings = [Feeding]()
    var chave = "feedings"
    
    
    @IBAction func buttonFeeding(_ sender: Any) {
        self.openUrl(url: self.feedings[0].link!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSlideMenuButton()
        self.title = "Alimentação"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        let url = UrlProvider.Instance.lerUrl(sufix: "feedings.json")
        self.CallAlomo(url: url)

    }

    
    func openUrl(url: String){
        let websiteAddress = NSURL(string: url)
        UIApplication.shared.openURL(websiteAddress! as URL)
    }
    
    
    func CallAlomo(url:String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        });
        
    }
    
    func parseData(JSONData: Data){
        let carregamento = UserDefaults.standard.object(forKey: self.chave) as? NSDictionary
        
        SVProgressHUD.show(withStatus: "Carregando")
        
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            if carregamento != nil{
                let dictionaries = carregamento?["feedings"] as! [[String:AnyObject]]
                for dictionary in dictionaries{
                    let new = Feeding(array: dictionary)
                    self.feedings.append(new)
                }
            }else{
            
                let dictionaries = json["feedings"] as! [[String:AnyObject]]
                for dictionary in dictionaries{
                    let new = Feeding(array: dictionary)
                    self.feedings.append(new)
                }
            }
            
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
            }
            
        
        } catch let erro as NSError {
            print("Aconteceu um erro de sessão! \(erro.description)")
            SVProgressHUD.dismiss()
            //self.showAlert(title: "Aconteceu algum problema", message: "\(erro.description)")
        }
    }


}
