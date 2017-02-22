//
//  TypsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 12/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CTypsViewController: BaseViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var category = [CType]()
    var chave = "category_typs"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSlideMenuButton()
        self.title = "Categorias"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        let url = UrlProvider.Instance.lerUrl(sufix: "category-typs.json")
        self.callAlo(url: url)
    }

    func callAlo(url:String){
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
                let categoriesDictionaries = carregamento["cTypes"] as! [[String:AnyObject]]
                for categoryDictionary in categoriesDictionaries{
                    let new = CType(array: categoryDictionary)
                    self.category.append(new)
                }
                
            }else{
                let categoriessDictionaries = json["cTypes"] as! [[String:AnyObject]]
                for categoryDictionary in categoriessDictionaries{
                    let new = CType(array: categoryDictionary)
                    self.category.append(new)
                }
            }
            
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            }
            
        } catch let erro as NSError {
            print("Aconteceu um erro de sessão! \(erro.description)")
            SVProgressHUD.dismiss()
            self.showAlert(title: "Aconteceu algum problema", message: "\(erro.description)")
        }
        
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CTypesCell", for: indexPath)
        
        cell.textLabel?.text = self.category[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TypesSegue"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let select = self.category[indexPath.row]
                let viewControllerDestino = segue.destination as! TypsViewController
                viewControllerDestino.conteudo = select
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
