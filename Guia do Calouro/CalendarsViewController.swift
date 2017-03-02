//
//  CalendarsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 10/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CalendarsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var chave =  "month_calendars"
    var months = [MonthCalendar]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        self.title = "Calendário - Meses"
        
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
    
        
        let urlMonth = UrlProvider.Instance.lerUrl(sufix: "month-calendars.json")
        
        self.CallAlomo(urlMonth:urlMonth);
        
        
    }

    func CallAlomo(urlMonth:String){
        Alamofire.request(urlMonth).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        });
        
    }
    
    func parseData(JSONData: Data){
        let carregamento = UserDefaults.standard.object(forKey: self.chave) as! NSDictionary
        SVProgressHUD.show(withStatus: "Carregando")
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            if carregamento != nil{
                if carregamento != json {
                    let monthDictionaries = json["monthCalendars"] as! [[String:AnyObject]]
                    for monthDictionary in monthDictionaries{
                        let newMonth = MonthCalendar(array: monthDictionary)
                        self.months.append(newMonth)
                    }
                }else{
                    let monthDictionaries = carregamento["monthCalendars"] as! [[String:AnyObject]]
                    for monthDictionary in monthDictionaries{
                        let newMonth = MonthCalendar(array: monthDictionary)
                        self.months.append(newMonth)
                    }
                }
                
            }else{
                print("Encontrou nulo")
                let monthDictionaries = json["monthCalendars"] as! [[String:AnyObject]]
                for monthDictionary in monthDictionaries{
                    let newMonth = MonthCalendar(array: monthDictionary)
                    self.months.append(newMonth)
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
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.months.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath)
        
        celula.textLabel?.text = self.months[indexPath.row].name        
        return celula;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MonthSegue"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let monthSelect = self.months[indexPath.row]
                let viewControllerDestino = segue.destination as! MonthCalendarsViewController
                viewControllerDestino.conteudo = monthSelect
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
