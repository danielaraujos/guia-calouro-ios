//
//  BuildingMapsViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 24/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SVProgressHUD

class BuildingMapsViewController: UIViewController, MKMapViewDelegate  {

    @IBOutlet weak var mapa: MKMapView!
    //var gerenciadorDeLocal = CLLocationManager()
    
    var chave = "buildings"
    var buildings = [Building]()
    var anota = [MKAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Mapa"
        
        let latitude: CLLocationDegrees = -19.217931
        let longitude: CLLocationDegrees = -46.223304
        
        let localizacao:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        
        let regiao : MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
        mapa.setRegion(regiao, animated: true)
        
        
        mapa.mapType = MKMapType.hybrid
        
        //-19.2178904,-46.2253201
        let pva =  MKPointAnnotation()
        pva.coordinate.latitude = -19.2176
        pva.coordinate.longitude = -46.2235
        pva.coordinate = localizacao
        pva.title = "PVA"
        pva.subtitle = "Prédio de Pavilhão de aulas"
        
        
        //-19.22419,-46.2227947
        let bbt = MKPointAnnotation()
        bbt.coordinate.latitude = -19.2190
        bbt.coordinate.longitude = -46.2229
        bbt.title = "BBT"
        bbt.subtitle = "Biblioteca "
        
        //-19.2197763,-46.2280062
        let ru = MKPointAnnotation()
        ru.coordinate.latitude = -19.2199
        ru.coordinate.longitude = -46.2231
        ru.title = "RU"
        ru.subtitle = "Restaurante Universitario "
        
        mapa.addAnnotations([pva, bbt, ru])
        
    }

}
