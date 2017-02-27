//
//  AboutsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 12/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class AboutsViewController: BaseViewController {

    @IBOutlet weak var textInfo: UITextView!
    
    var abouts = [About]()
    var chave = "abouts"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSlideMenuButton()
        self.title = "Sobre"
        
        let url = UrlProvider.Instance.lerUrl(sufix: "abouts.json")
        self.CallAlomo(url: url)
        
        //textInfo.text = self.abouts[0].body
        
        //print(self.abouts)
        self.buttonFloat()
    }
    
    
    func buttonFloat(){
        let fab = KCFloatingActionButton()
        fab.addItem("Compartilhar", icon: UIImage(named: "icShare")!, handler: { item in
            let textToShare = "Baixe o Guia do Calouro - UFV/CRP"
            if let myWebsite = NSURL(string: "https://itunes.apple.com/us/app/hinário-novo-cantico/id1200173802") {
                let objectsToShare = [textToShare, myWebsite] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
                
                activityVC.popoverPresentationController?.sourceView = self.view
                
                self.present(activityVC, animated: true, completion: nil)
            }
            
            fab.close()
        })
        fab.addItem("Avaliar", icon: UIImage(named: "icShare")!, handler: { item in
            self.rateApp(appId: "id1200173802", completion: { (success) in
                print("RateApp \(success)")
            })
            fab.close()
        })
        fab.addItem("Contato", icon: UIImage(named: "icShare")!, handler: { item in
            
            fab.close()
        })
        fab.buttonColor = UIColor.red
        fab.plusColor = UIColor.white
        self.view.addSubview(fab)
    
    
    
    }
    
    
    
    
    
    //Avaliacao na apple store
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    
    

    func CallAlomo(url:String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
            self.textInfo.text = self.abouts[0].body!
        });
        
    }
    
    func parseData(JSONData: Data){
        let carregamento = UserDefaults.standard.object(forKey: self.chave) as? NSDictionary
        
        SVProgressHUD.show(withStatus: "Carregando")
        
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            if carregamento != nil{
                let dictionaries = carregamento?["abouts"] as! [[String:AnyObject]]
                for dictionary in dictionaries{
                    let new = About(array: dictionary)
                    self.abouts.append(new)
                }
            }else{
                
                let dictionaries = json["abouts"] as! [[String:AnyObject]]
                for dictionary in dictionaries{
                    let new = About(array: dictionary)
                    self.abouts.append(new)
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
