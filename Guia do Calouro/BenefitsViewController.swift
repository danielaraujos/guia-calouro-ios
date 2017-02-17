//
//  BenefitsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 11/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SVProgressHUD

class BenefitsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var chave = "benefits"
    var benefits = [Benefit]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        self.title = "Benefícios"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        let url = UrlProvider.Instance.lerUrl(sufix: "benefits.json")
        self.CallAlomo(url: url)
        
        
    }
    
    func CallAlomo(url:String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        });
        
    }
    
    func parseData(JSONData: Data){
        let carregamento = UserDefaults.standard.object(forKey: self.chave) as! NSDictionary
        
        let methodStart = Date()
        SVProgressHUD.show(withStatus: "Carregando")
        
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            print(json)
            
            if carregamento != nil{
                let benefitsDictionaries = carregamento["benefits"] as! [[String:AnyObject]]
                for benefitDictionary in benefitsDictionaries{
                    let newBenefits = Benefit(array: benefitDictionary)
                    self.benefits.append(newBenefits)
                }

                
            }else{
                print("Encontrou nulo")
                let benefitsDictionaries = json["benefits"] as! [[String:AnyObject]]
                for benefitDictionary in benefitsDictionaries{
                    let newBenefits = Benefit(array: benefitDictionary)
                    self.benefits.append(newBenefits)
                }
            }
            
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }
            
        } catch let erro as NSError {
            print("Aconteceu um erro de sessão! \(erro.description)")
            SVProgressHUD.dismiss()
            //self.showAlert(title: "Aconteceu algum problema", message: "\(erro.description)")
        }
        
        let methodFinally = Date()
        let execulteTime = methodFinally.timeIntervalSince(methodStart)
        print(execulteTime)
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.benefits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let benefit = self.benefits[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CellBenefits", for: indexPath) as! BenefitsCelula
        
        Alamofire.request(UrlProvider.Instance.letImage(sufix:"\(benefit.dir!)\(benefit.image!)")).responseImage { response in
            if let image = response.result.value {
                cell.imageBenefits.image = image
            }
        }
        cell.lblTitle.text = benefit.title
        cell.lblSubTitle.text = benefit.sub_title
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BenefitsSegue"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let benefitsSelect = self.benefits[indexPath.row]
                let viewControllerDestino = segue.destination as! BenefitsDetailsViewController
                viewControllerDestino.benefitsGet = benefitsSelect
            }
        }
    }


    

   

}
