//
//  ManagementsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 12/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ManagementsViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var managements = [Management]()
    var tmp = [Management]()
    var chave = "managements"
    var cManagement : CManagement!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Gestão"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        let url = UrlProvider.Instance.lerUrl(sufix: "managements.json")
        self.callAlamofire(url: url);
        
    }

    func callAlamofire(url: String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
    }
    
    func parseData(JSONData: Data){
        let carregamento = UserDefaults.standard.object(forKey: self.chave) as! NSDictionary
        
        SVProgressHUD.show(withStatus: "Carregando")
        
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            //print(json)
            
            if carregamento != nil{
                let categoriesDictionaries = carregamento["managements"] as! [[String:AnyObject]]
                for categoryDictionary in categoriesDictionaries{
                    let new = Management(array: categoryDictionary)
                    self.managements.append(new)
                }
                
                for management1 in managements{
                    if(self.cManagement.id! == management1.category_management_id!){
                        let new = Management(id: management1.id!, function: management1.function!, name: management1.name!, room: management1.room!, email: management1.email!, phone: management1.phone!, category_management_id: management1.category_management_id!)
                        self.tmp.append(new)
                    }
                }

            }else{
                let categoriessDictionaries = json["managements"] as! [[String:AnyObject]]
                for categoryDictionary in categoriessDictionaries{
                    let new = Management(array: categoryDictionary)
                    self.managements.append(new)
                }
                
                for management1 in managements{
                    if(self.cManagement.id! == management1.category_management_id!){
                        let new = Management(id: management1.id!, function: management1.function!, name: management1.name!, room: management1.room!, email: management1.email!, phone: management1.phone!, category_management_id: management1.category_management_id!)
                        self.tmp.append(new)
                    }
                }
                
            }
            
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }
            
        } catch let erro as NSError {
            print("Aconteceu um erro de sessão! \(erro.description)")
            SVProgressHUD.dismiss()
            self.showAlert(title: "Ops... Problema encontrado", message:  "Desculpe! Aconteceu algum problema. Reinicie o aplicativo, caso não resolva... Nos mande uma mensagem.")
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tmp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagementCell", for: indexPath)
        cell.textLabel?.text = self.tmp[indexPath.row].function
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ManagementDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let selection = self.tmp[indexPath.row]
                let viewSelecionada =  segue.destination as! ManagementDetailViewController
                viewSelecionada.conteudo = selection
            }
        }
    }
    
    func showAlert(title:String, message:String){
        let alertaController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertaAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertaController.addAction(alertaAction)
        present(alertaController, animated: true, completion: nil)
    }
    
    
}
