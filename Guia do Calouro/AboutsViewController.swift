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
import MessageUI

class AboutsViewController: BaseViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var textInfo: UITextView!
    
    var abouts = [About]()
    var chave = "abouts"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSlideMenuButton()
        self.title = "Sobre"
        
        let url = UrlProvider.Instance.lerUrl(sufix: "abouts.json")
        self.CallAlomo(url: url)
        self.buttonFloat()
    }
    
    
    func buttonFloat(){
        let fab = KCFloatingActionButton()
        fab.addItem("Compartilhar", icon: UIImage(named: "icShare")!, handler: { item in
            let site = "https://itunes.apple.com/us/app/guia-do-calouro/id1211493779"
            let activitiVC = UIActivityViewController(activityItems: [site], applicationActivities: nil)
            activitiVC.popoverPresentationController?.sourceView = self.view
            self.present(activitiVC, animated: true, completion: nil)
            fab.close()
        })
        
        fab.addItem("Avaliar", icon: UIImage(named: "icRating")!, handler: { item in
            self.rateApp(appId: "id1211493779", completion: { (success) in
                print("RateApp \(success)")
            })
            fab.close()
        })

        fab.addItem("Contato", icon: UIImage(named: "icMail")!, handler: { item in
            self.sendEmail()
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
                if carregamento != json {
                    let dictionaries = json["abouts"] as! [[String:AnyObject]]
                    for dictionary in dictionaries{
                        let new = About(array: dictionary)
                        self.abouts.append(new)
                    }
                }else{
                    let dictionaries = carregamento?["abouts"] as! [[String:AnyObject]]
                    for dictionary in dictionaries{
                        let new = About(array: dictionary)
                        self.abouts.append(new)
                    }
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
            self.showAlert(title: "Ops... Problema encontrado", message:  "Desculpe! Aconteceu algum problema. Reinicie o aplicativo, caso não resolva... Nos mande uma mensagem.")
        }
    }
    
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["daniel.araujos@icloud.com"])
            mail.setMessageBody("<p>Dispositivo: \(UIDevice.current.name)</p>", isHTML: true)
            mail.setSubject("Opinião sobre o aplicativo Guia do Calouro")
            
            present(mail, animated: true)
        } else {
            self.showAlert(title: "Ops.", message: "Ocorreu algum problema no envio. Tente novamente mais tarde!")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func showAlert(title:String, message:String){
        let alertaController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertaAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertaController.addAction(alertaAction)
        present(alertaController, animated: true, completion: nil)
    }
}
