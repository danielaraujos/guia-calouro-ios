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
        print(self.calendar)
        print("compartilhando")
        let textToShare = "Guia do Calouro - Calendário"
        if let myWebsite = NSURL(string: self.calendar) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            
            activityVC.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }

}
