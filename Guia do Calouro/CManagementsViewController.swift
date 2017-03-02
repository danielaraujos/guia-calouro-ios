//
//  CManagementsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 20/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CManagementsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var categories = [CManagement]()
    var chave = "category_managements"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSlideMenuButton()
        self.title = "Gestão"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        let url = UrlProvider.Instance.lerUrl(sufix: "category-managements.json")
        self.callAlamofire(url: url)
        
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
                let categoriesDictionaries = carregamento["CManagements"] as! [[String:AnyObject]]
                for categoryDictionary in categoriesDictionaries{
                    let new = CManagement(array: categoryDictionary)
                    self.categories.append(new)
                }
                
                
            }else{
                let categoriessDictionaries = json["CManagements"] as! [[String:AnyObject]]
                for categoryDictionary in categoriessDictionaries{
                    let new = CManagement(array: categoryDictionary)
                    self.categories.append(new)
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
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CManagementsCell", for: indexPath)
        
        cell.textLabel?.text = self.categories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ManagementeSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let selection = self.categories[indexPath.row]
                let viewSelecionada =  segue.destination as! ManagementsViewController
                viewSelecionada.cManagement = selection
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
