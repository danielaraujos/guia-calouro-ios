//
//  ManagementDetailViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 21/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit

class ManagementDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    //ManagementDetailCell
    var conteudo: Management!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.conteudo.function!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1{
            return 1
        }else if section == 2{
            return 1
        }else if section == 3{
            return 1
        }else if section == 4 {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Cargo:"
        }else if section == 1{
            return "Nome:"
        }else if section == 2{
            return "Número da sala:"
        }else if section == 3{
            return "E-mail:"
        }else if section == 4 {
            return "Telefone:"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagementDetailCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = conteudo.function!
        }else if indexPath.section == 1{
            cell.textLabel?.text = conteudo.name!
        }else if indexPath.section == 2{
            cell.textLabel?.text = conteudo.room!
        }else if indexPath.section == 3{
            cell.textLabel?.text = conteudo.email!
        }else if indexPath.section == 4 {
            cell.textLabel?.text = conteudo.phone!
        }

        return cell
    }
    
    
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in
                    print("Open \(scheme): \(success)")
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        

        self.tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            
        }else if indexPath.section == 1{
            
        }else if indexPath.section == 2{
            
        }else if indexPath.section == 3{
            
        }else if indexPath.section == 4 {
            open(scheme: "tel://\(conteudo.phone!)")
            
        }
        
    }


    


}
