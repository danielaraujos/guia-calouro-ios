//
//  UsefulDetailViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 16/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import  Alamofire
import SVProgressHUD

class UsefulDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    
    var telephone: Telephone!
    var email: Email!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.telephone != nil{
            self.title = self.telephone.name
        }
        
        if self.email != nil{
            self.title = self.email.name
        }
    }
    
    ///UsefulDetailCell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.telephone != nil {
            if section == 0 {
                return "Nome:"
            }else if section == 1{
                return "Setor:"
            }else if section == 2{
                return "Telefone"
            }
        }else {
            if section == 0 {
                return "Nome:"
            }else if section == 1{
                return "Email:"
            }else if section == 2{
                return "Telefone"
            }
        }
        
        return ""
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsefulDetailCell", for: indexPath)
        
        if self.telephone != nil {
            if indexPath.section == 0 {
                cell.textLabel?.text = self.telephone.name!
            }else if indexPath.section == 1{
                cell.textLabel?.text = self.telephone.sector!
            }else if indexPath.section == 2{
                cell.textLabel?.text = self.telephone.phone!
            }
        
        }else{
            if indexPath.section == 0 {
                cell.textLabel?.text = self.email.name!
            }else if indexPath.section == 1{
                cell.textLabel?.text = self.email.mail
            }else if indexPath.section == 2{
                cell.textLabel?.text = self.email.phone
            }
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
        if self.telephone != nil {
        
            if indexPath.section == 0 {
                
            }else if indexPath.section == 1{
                
            }else if indexPath.section == 2{
                 open(scheme: "tel://\(self.telephone.phone!)")
            }
        }else{
            
            if indexPath.section == 0 {
                
            }else if indexPath.section == 1{
                
            }else if indexPath.section == 2{
            }
        
        
        }
        
    }

    
    
}
