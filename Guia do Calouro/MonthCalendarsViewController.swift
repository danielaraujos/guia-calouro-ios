//
//  MonthCalendarsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 10/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class MonthCalendarsViewController: BaseViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
  

    var chave = "calendars"
    var calendars = [Calendar]()
    var tmp = [String]()
    var conteudo: MonthCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendário - \(conteudo.name!)"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        let url = UrlProvider.Instance.lerUrl(sufix: "calendars.json")
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
        
        SVProgressHUD.show(withStatus: "Carregando")
        
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        
            if carregamento != nil{
                let calendarDictionaries = carregamento["calendars"] as! [[String:AnyObject]]
                for calendarDictionary in calendarDictionaries{
                    let newCalendar = Calendar(array: calendarDictionary)
                    self.calendars.append(newCalendar)
                }
                for calendar in calendars{
                    if( conteudo.id! == calendar.month_calendar_id){
                        self.tmp.append(calendar.name!)
                    }
                }
            }else{
                print("Encontrou nulo")
                let calendarDictionaries = json["calendars"] as! [[String:AnyObject]]
                for calendarDictionary in calendarDictionaries{
                    let newCalendar = Calendar(array: calendarDictionary)
                    self.calendars.append(newCalendar)
                }
                for calendar in calendars{
                    if( conteudo.id! == calendar.month_calendar_id){
                        self.tmp.append(calendar.name!)
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
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tmp.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "MonthCell", for: indexPath)
        celula.textLabel?.text = self.tmp[indexPath.row]
        return celula;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailCalendar"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let monthSelect = self.tmp[indexPath.row]
                let viewControllerDestino = segue.destination as! CalendarDetailViewController
                viewControllerDestino.calendar = monthSelect
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
