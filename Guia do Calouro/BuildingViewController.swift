//
//  BuildingViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 10/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SVProgressHUD

class BuildingViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var chave = "buildings"
    var buildings = [Building]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        
        self.title = "Prédios"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        let url = UrlProvider.Instance.lerUrl(sufix: "buildings.json")
        self.CallAlomo(url: url);
        

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
                let buildingDictionaries = carregamento?["buildings"] as! [[String:AnyObject]]
                for buildingDictionary in buildingDictionaries{
                    let newBuilding = Building(array: buildingDictionary)
                    self.buildings.append(newBuilding)
                }
            }else{
                print("Encontrou nulo")
                let buildingDictionaries = json["buildings"] as! [[String:AnyObject]]
                for buildingDictionary in buildingDictionaries{
                    let newBuilding = Building(array: buildingDictionary)
                    self.buildings.append(newBuilding)
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
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.buildings.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let b = self.buildings[indexPath.row]
        let celula = tableView.dequeueReusableCell(withIdentifier: "CellBuilding", for: indexPath) as! BuildingCelula
        
    
        Alamofire.request(UrlProvider.Instance.letImage(sufix:"\(b.dir!)\(b.image!)")).responseImage { response in
            if let image = response.result.value {
                celula.imageBuilding.image = image
            }
        }
        
        celula.lblTitle.text = b.name;
        celula.lblSubTitle.text = b.sub_name
        return celula;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BuildingSegue"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let buildingSelect = self.buildings[indexPath.row]
                let viewControllerDestino = segue.destination as! BuildingDetailViewController
                viewControllerDestino.buildingGet = buildingSelect
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
