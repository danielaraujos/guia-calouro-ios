//
//  UsefulViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 12/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit

class UsefulViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var userful = [Useful]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSlideMenuButton()
        
        self.title = "Utilidades"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        self.getListagem()
    }
    
    func getListagem(){
        var user: Useful;
        user = Useful(id: 1, name: "Telefones Úteis")
        self.userful.append(user)
        
        user = Useful(id: 2, name: "E-mails Institucionais")
        self.userful.append(user)
        
        user = Useful(id: 3, name: "Telefones Comerciais")
        self.userful.append(user)
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userful.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let b = self.userful[indexPath.row]
        let celula = tableView.dequeueReusableCell(withIdentifier: "UserfulCell", for: indexPath)
        
        celula.textLabel?.text = b.name
        
        return celula
    }

    
}
