//
//  TelephonesViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 16/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import  Alamofire
import SVProgressHUD


class PUsefulViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UISearchResultsUpdating {

    var pGet: Useful!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var chave: String?
    var telephones = [Telephone]()
    var emails = [Email]()
    
    //FILTRO
    var filterTelephones = [Telephone]()
    var filterEmails = [Email]()
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        
        if (self.pGet.id! == 1) {
            //Telephones
            print("Telephones")
            self.chave = "telephones"
            self.title = self.pGet.name!
            let url = UrlProvider.Instance.lerUrl(sufix: "telephones.json")
            self.CallAlomo(url: url)
            
        }
        else if (self.pGet.id! == 2){
            //Email
            print("Email")
            self.chave = "emails"
            self.title = self.pGet.name!
            let url = UrlProvider.Instance.lerUrl(sufix: "emails.json")
            self.CallAlomo(url: url)
        
        }
        
        //INICIALIAR SEARCHBAR
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    func CallAlomo(url:String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        });
        
    }
    
    func parseData(JSONData: Data){
        let carregamento = UserDefaults.standard.object(forKey: self.chave!) as? NSDictionary
        
        SVProgressHUD.show(withStatus: "Carregando")
        
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            if carregamento != nil{
                if (self.pGet.id! == 1 ){
                    let telephonesDictionaries = carregamento?["telephones"] as! [[String:AnyObject]]
                    for telephoneDictionary in telephonesDictionaries{
                        let newTelephones = Telephone(array: telephoneDictionary)
                        self.telephones.append(newTelephones)
                    }
                } else if(pGet.id! == 2){
                    let emailsDictionaries = carregamento?["emails"] as! [[String:AnyObject]]
                    for emailDictionary in emailsDictionaries{
                        let newEmails = Email(array: emailDictionary)
                        self.emails.append(newEmails)
                    }
                }
                
                else{
                    if (self.pGet.id! == 1 ){
                        let telephonesDictionaries = json["telephones"] as! [[String:AnyObject]]
                        for telephoneDictionary in telephonesDictionaries{
                            let newTelephones = Telephone(array: telephoneDictionary)
                            self.telephones.append(newTelephones)
                        }
                    } else if(pGet.id! == 2){
                        let emailsDictionaries = json["emails"] as! [[String:AnyObject]]
                        for emailDictionary in emailsDictionaries{
                            let newEmails = Email(array: emailDictionary)
                            self.emails.append(newEmails)
                        }
                    }

                }
                
                
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                }
                
                
            }else{
                print("Encontrou nulo")
            }
            
        } catch let erro as NSError {
            print("Aconteceu um erro de sessão! \(erro.description)")
            SVProgressHUD.dismiss()
            self.showAlert(title: "Ops... Problema encontrado", message:  "Desculpe! Aconteceu algum problema. Reinicie o aplicativo, caso não resolva... Nos mande uma mensagem.")
        }
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.pGet.id! == 1) {
            if searchController.isActive && searchController.searchBar.text != ""{
                return self.filterTelephones.count
            }else{
                return self.telephones.count
            }
        }else{
            if searchController.isActive && searchController.searchBar.text != ""{
                return self.filterEmails.count
            }else{
                return self.emails.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PUsefulCell", for: indexPath)
        if (self.pGet.id! == 1){
            if searchController.isActive && searchController.searchBar.text != ""{
                cell.textLabel?.text = self.filterTelephones[indexPath.row].name!
            }else{
                cell.textLabel?.text = self.telephones[indexPath.row].name!
            }
            
            return cell
        }
        
        else{
            if searchController.isActive && searchController.searchBar.text != ""{
                cell.textLabel?.text = self.filterEmails[indexPath.row].name!
            }else{
                cell.textLabel?.text = self.emails[indexPath.row].name!
            }
            return cell
        
        }
        
    }
    
    func filterContentForSearch(searchString:String){
       
        if (self.pGet.id! == 1){
            self.filterTelephones = self.telephones.filter(){
                nil != $0.name?.range(of: searchString)
            }
            
            self.tableView.reloadData()
        }
        else{
            self.filterEmails = self.emails.filter(){
                nil != $0.name?.range(of: searchString)
            }
            
        }
        self.tableView.reloadData()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearch(searchString: searchController.searchBar.text!)
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UsefulDetailCell"{
            if let indexPath = tableView.indexPathForSelectedRow{
                if(self.pGet.id! == 1){
                    if searchController.isActive && searchController.searchBar.text != ""{
                        let select = self.filterTelephones[indexPath.row]
                        let viewControllerDestino = segue.destination as! UsefulDetailViewController
                        viewControllerDestino.telephone = select
                    }else{
                        let select = self.telephones[indexPath.row]
                        let viewControllerDestino = segue.destination as! UsefulDetailViewController
                        viewControllerDestino.telephone = select
                    }

                }else{
                    if searchController.isActive && searchController.searchBar.text != ""{
                        let select = self.filterEmails[indexPath.row]
                        let viewControllerDestino = segue.destination as! UsefulDetailViewController
                        viewControllerDestino.email = select
                    }else{
                        let select = self.emails[indexPath.row]
                        let viewControllerDestino = segue.destination as! UsefulDetailViewController
                        viewControllerDestino.email = select
                    }
                }
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
