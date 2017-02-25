//
//  TransportsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 12/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import SVProgressHUD

class TransportsViewController: BaseViewController ,MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        
        self.title = "Transportes"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        self.localizacaoMaps()
    }

    func localizacaoMaps(){
        let latitude: CLLocationDegrees = -19.1942
        let longitude: CLLocationDegrees = -46.2474
        
        let localizacao:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let regiao : MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
        mapa.setRegion(regiao, animated: true)
        
        //mapa.mapType = MKMapType.hybrid
        
                
        
        let ponto1 =  MKPointAnnotation()
        ponto1.coordinate.latitude = -19.1942
        ponto1.coordinate.longitude = -46.2474
        ponto1.coordinate = localizacao
        ponto1.title = "Ponto 1 "
        ponto1.subtitle = "Praça Central"
        
        
        
        let ponto2 = MKPointAnnotation()
        ponto2.coordinate.latitude = -19.1956
        ponto2.coordinate.longitude = -46.2448
        ponto2.title = "Ponto 2"
        ponto2.subtitle = "Ponto 2 "
        
        
        let ponto3 = MKPointAnnotation()
        ponto3.coordinate.latitude = -19.1971
        ponto3.coordinate.longitude = -46.2418
        ponto3.title = "Ponto 3"
        ponto3.subtitle = "Ponto 3"
        
        let ponto4 = MKPointAnnotation()
        ponto4.coordinate.latitude = -19.1980
        ponto4.coordinate.longitude = -46.2374
        ponto4.title = "Ponto 4"
        ponto4.subtitle = "Ponto 4"
        
        let ponto5 = MKPointAnnotation()
        ponto5.coordinate.latitude = -19.2010
        ponto5.coordinate.longitude = -46.2373
        ponto5.title = "Ponto 5"
        ponto5.subtitle = "Ponto 5"
        
        
        mapa.addAnnotations([ponto1, ponto2,ponto3,ponto4, ponto5])

    }
    
    
    /*
     Transports	Listagem de Transporte
     Shifts	Listagem de turno
     Schedules	Listagem de Horário	
     Places	Listagem de locais
     
     
     self.CallAlomo(url: self.transports!,valueCall: "transports",valueKey: "transports");
     self.CallAlomo(url: self.shifts! ,valueCall: "shifts",valueKey: "shifts");
     self.CallAlomo(url: self.schedules!,valueCall: "schedules",valueKey: "schedules");
     self.CallAlomo(url: self.places! ,valueCall: "places",valueKey: "places");
     
     */
    
    
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else if section == 1{
            return 3
        }else if section == 2{
            return 3
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Horário da Manhã:"
        }else if section == 1{
            return "Horário da Tarde:"
        }else if section == 2{
            return "Horário da Noite"
        }
        return ""
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransportesCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "ida: 1"
        }else if indexPath.section == 1{
            cell.textLabel?.text = "ida: 2"
        }else if indexPath.section == 2{
            cell.textLabel?.text = "ida: 3"
        }

        return cell
    }

    
    
    
}
