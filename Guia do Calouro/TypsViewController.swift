//
//  TypsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 20/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class TypsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    
    var typs = [Type]()
    var chave = "typs"
    var conteudo: CType!
    var tmp = [Type]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.conteudo.name!
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        
        let url = UrlProvider.Instance.lerUrl(sufix: "typs.json")
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
            
           // print(json)
            
            if carregamento != nil{
                if json != carregamento {
                    let typsDictionaries = json["typs"] as! [[String:AnyObject]]
                    for typeDictionary in typsDictionaries{
                        let new = Type(array: typeDictionary)
                        self.typs.append(new)
                    }
                    for type in typs{
                        if( conteudo.id! == type.category_typ_id!){
                            let new = Type(id: type.id!, name: type.name!, body: type.body!, name_link: type.name_link!, link: type.link!, category_typ_id: type.category_typ_id!)
                            self.tmp.append(new)
                            
                        }
                    }
                
                }else{
                    let typsDictionaries = carregamento["typs"] as! [[String:AnyObject]]
                    for typeDictionary in typsDictionaries{
                        let new = Type(array: typeDictionary)
                        self.typs.append(new)
                    }
                    
                    for type in typs{
                        if( conteudo.id! == type.category_typ_id!){
                            let new = Type(id: type.id!, name: type.name!, body: type.body!, name_link: type.name_link!, link: type.link!, category_typ_id: type.category_typ_id!)
                            self.tmp.append(new)
                            
                        }
                    }
                    
                
                }
                
            }else{
                let typsDictionaries = json["typs"] as! [[String:AnyObject]]
                for typeDictionary in typsDictionaries{
                    let new = Type(array: typeDictionary)
                    self.typs.append(new)
                }
                for type in typs{
                    if( conteudo.id! == type.category_typ_id!){
                        let new = Type(id: type.id!, name: type.name!, body: type.body!, name_link: type.name_link!, link: type.link!, category_typ_id: type.category_typ_id!)
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
            self.showAlert(title: "Aconteceu algum problema", message: "\(erro.description)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tmp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        
        cell.textLabel?.text = self.tmp[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueTypsDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let select = self.tmp[indexPath.row]
                let viewControllerDestino =  segue.destination as! TypsDetailViewController
                viewControllerDestino.typs = select
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
