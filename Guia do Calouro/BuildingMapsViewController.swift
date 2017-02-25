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
        
        let url = UrlProvider.Instance.lerUrl(sufix: "buildings.json")
        self.CallAlomo(url: url);

    
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

    
//    func localizacaoCompleta(){
//        for item in self.buildings {
//            var name = item.name as! MKPointAnnotation
//            name = MKPointAnnotation()
//            
//            name.coordinate.latitude = (item.latitude as? CLLocationDegrees)!
//            name.coordinate.longitude = (item.longitude as? CLLocationDegrees)!
//            name.title = item.name!
//            name.subtitle = item.sub_name!
//            self.anota.append(name)
//            
//        }
//        mapa.addAnnotations(self.anota)
//
//
//    }
    
    
    func novafuncao(){
    
//        coordinates = [[48.85672,2.35501],[48.85196,2.33944],[48.85376,2.33953]]// Latitude,Longitude
//        names = ["Coffee Shop · Rue de Rivoli","Cafe · Boulevard Saint-Germain","Coffee Shop · Rue Saint-André des Arts"]
//        addresses = ["46 Rue de Rivoli, 75004 Paris, France","91 Boulevard Saint-Germain, 75006 Paris, France","62 Rue Saint-André des Arts, 75006 Paris, France"]
//        phones = ["+33144789478","+33146345268","+33146340672"]
//        self.mapView.delegate = self
//        // 2
//        for i in 0...2
//        {
//            let coordinate = coordinates[i]
//            let point = StarbucksAnnotation(coordinate: CLLocationCoordinate2D(latitude: coordinate[0] , longitude: coordinate[1] ))
//            point.image = UIImage(named: "starbucks-\(i+1).jpg")
//            point.name = names[i]
//            point.address = addresses[i]
//            point.phone = phones[i]
//            self.mapView.addAnnotation(point)
//        }
        
        
        

    }



    
    func CallAlomo(url:String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        });
        
    }
    
    func parseData(JSONData: Data){
        let carregamento = UserDefaults.standard.object(forKey: self.chave) as? NSDictionary
        
        SVProgressHUD.show(withStatus: "Carregando")
        
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            
            if carregamento != nil{
                let buildingDictionaries = carregamento?["buildings"] as! [[String:AnyObject]]
                for buildingDictionary in buildingDictionaries{
                    let newBuilding = Building(array: buildingDictionary)
                    self.buildings.append(newBuilding)
                    
                }
                
                
                
                
            }else{
                print("Encontrou nulo")
                let buildingDictionaries = json["buildings"] as! [[String:AnyObject]]
                for buildingDictionary in buildingDictionaries{
                    let newBuilding = Building(array: buildingDictionary)
                    self.buildings.append(newBuilding)
                }
            }
            
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
            }
        
            
            
            
        } catch let erro as NSError {
            print("Aconteceu um erro de sessão! \(erro.description)")
            SVProgressHUD.dismiss()
            self.showAlert(title: "Aconteceu algum problema", message: "\(erro.description)")
        }
        
        
    }
    
    func showAlert(title:String, message:String){
        let alertaController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertaAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertaController.addAction(alertaAction)
        present(alertaController, animated: true, completion: nil)
    }
    


}
