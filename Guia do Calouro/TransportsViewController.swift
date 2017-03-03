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
   
    var schedules = [Schedule]()
    var schedulesTarde = [Schedule]()
    var schedulesNoite = [Schedule]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        
        self.title = "Transportes"
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
    
        self.getListagem()
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
        ponto1.subtitle = "Rua Otaviano Rosa(Praça da Igreja)"
        
        
        
        let ponto2 = MKPointAnnotation()
        ponto2.coordinate.latitude = -19.1956
        ponto2.coordinate.longitude = -46.2448
        ponto2.title = "Ponto 2"
        ponto2.subtitle = "Rua Ver. Antônio de Carvalho (Igreja do Rosário) "
        
        
        let ponto3 = MKPointAnnotation()
        ponto3.coordinate.latitude = -19.1971
        ponto3.coordinate.longitude = -46.2418
        ponto3.title = "Ponto 3"
        ponto3.subtitle = "Rua Vereador Augusto Antonio de Carvalho"
        
        let ponto4 = MKPointAnnotation()
        ponto4.coordinate.latitude = -19.1980
        ponto4.coordinate.longitude = -46.2374
        ponto4.title = "Ponto 4"
        ponto4.subtitle = "Rua Cap. Franklin de Castro (Posto Geraldinho)"
        
        let ponto5 = MKPointAnnotation()
        ponto5.coordinate.latitude = -19.2010
        ponto5.coordinate.longitude = -46.2373
        ponto5.title = "Ponto 5"
        ponto5.subtitle = "Rua São Gotardo (Ribeiro 2)"
        
        
        mapa.addAnnotations([ponto1, ponto2,ponto3,ponto4, ponto5])

    }
    
    
    func getListagem(){
        var schedules: Schedule;
        schedules = Schedule(id: 1, name: "Ida: 7:30 - 07:50", shifts_id: 1)
        self.schedules.append(schedules)
        
        schedules = Schedule(id: 2, name: "Intervalo: 09:30 - 10:00", shifts_id: 1)
        self.schedules.append(schedules)
        
        schedules = Schedule(id: 3, name: "Volta: 11:30", shifts_id: 1)
        self.schedules.append(schedules)
        
        schedules = Schedule(id: 4, name: "Ida: 13:30 - 13:50", shifts_id: 2)
        self.schedulesTarde.append(schedules)
        
        schedules = Schedule(id: 5, name: "Intervalo: 15:30 - 16:00", shifts_id: 2)
        self.schedulesTarde.append(schedules)
        
        schedules = Schedule(id: 6, name: "Volta: 17:30", shifts_id: 2)
        self.schedulesTarde.append(schedules)
        
        schedules = Schedule(id: 7, name: "Ida: 18:30 - 18:50", shifts_id: 3)
        self.schedulesNoite.append(schedules)
        
        schedules = Schedule(id: 8, name: "Intervalo: 20:30 - 21:00", shifts_id: 3)
        self.schedulesNoite.append(schedules)
        
        schedules = Schedule(id: 9, name: "Volta: 22:30", shifts_id: 3)
        self.schedulesNoite.append(schedules)
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.schedules.count
        }else if section == 1{
            return self.schedulesTarde.count
        }else if section == 2{
            return self.schedulesNoite.count
        }
        return 0
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
        let s = self.schedules[indexPath.row]
        let t = self.schedulesTarde[indexPath.row]
        let n = self.schedulesNoite[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransportesCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = s.name!
        }else if indexPath.section == 1 {
            cell.textLabel?.text = t.name!
        }else if indexPath.section == 2 {
            cell.textLabel?.text = n.name!
        }
        return cell
    }
    
    
}
