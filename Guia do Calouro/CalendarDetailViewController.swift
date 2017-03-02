//
//  CalendarDetailViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 20/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit

class CalendarDetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var calendar: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Informações"
        
        self.textView.text = calendar
        
        
        let fab = KCFloatingActionButton()
        fab.addItem("Compartilhar", icon: UIImage(named: "icShare")!, handler: { item in
            self.shared()
            fab.close()
        })
        fab.buttonColor = UIColor.red
        fab.plusColor = UIColor.white
        self.view.addSubview(fab)

    }

    func shared(){
        
        let activitiVC = UIActivityViewController(activityItems: [self.calendar], applicationActivities: nil)
        activitiVC.popoverPresentationController?.sourceView = self.view
        self.present(activitiVC, animated: true, completion: nil)
    }

}
