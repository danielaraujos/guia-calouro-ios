//
//  LoadingViewController.swift
//  Guia do Calouro
//
//  Created by Daniel Araújo on 09/02/17.
//  Copyright © 2017 Daniel Araújo Silva. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class LoadingViewController: UIViewController {

    var buildings: String?
    var benefits: String?
    var abouts: String?
    var calendars : String?
    var month_calendars: String?
    var typs: String?
    var category_typs: String?
    var telephones: String?
    var emails: String?
    var managements: String?
    var category_managements : String?
    var feedings: String?
    var transports: String?
    var shifts: String?
    var schedules: String?
    var places: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.urlProviders();
        self.CallUrls();
        //self.redirecionar()
    }
    
    func redirecionar(){
        print("Redirecionando")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigation") as! UINavigationController
        self.present(viewController, animated: true, completion: nil)

    }
    
    func urlProviders(){
        //Urls:
        self.buildings = UrlProvider.Instance.lerUrl(sufix: "buildings.json");
        self.benefits = UrlProvider.Instance.lerUrl(sufix: "benefits.json");
        self.abouts = UrlProvider.Instance.lerUrl(sufix: "abouts.json");
        self.calendars = UrlProvider.Instance.lerUrl(sufix: "calendars.json");
        self.month_calendars = UrlProvider.Instance.lerUrl(sufix: "month-calendars.json");
        self.typs = UrlProvider.Instance.lerUrl(sufix: "typs.json");
        self.category_typs = UrlProvider.Instance.lerUrl(sufix: "category-typs.json");
        self.telephones = UrlProvider.Instance.lerUrl(sufix: "telephones.json");
        self.emails = UrlProvider.Instance.lerUrl(sufix: "emails.json");
        self.managements = UrlProvider.Instance.lerUrl(sufix: "managements.json");
        self.category_managements = UrlProvider.Instance.lerUrl(sufix: "category-managements.json");
        self.feedings = UrlProvider.Instance.lerUrl(sufix: "feedings.json");
        self.transports = UrlProvider.Instance.lerUrl(sufix: "transports.json");
        self.shifts = UrlProvider.Instance.lerUrl(sufix: "shifts.json");
        self.schedules = UrlProvider.Instance.lerUrl(sufix: "schedules.json");
        self.places = UrlProvider.Instance.lerUrl(sufix: "places.json");
        
        
    }
    
    
    func CallUrls(){
        
        self.CallAlomo(url: self.buildings!,valueCall: "buildings", valueKey: "buildings" );
        self.CallAlomo(url: self.benefits! ,valueCall: "benefits",valueKey:  "benefits");
        self.CallAlomo(url: self.abouts!,valueCall: "abouts",valueKey:  "abouts");
        self.CallAlomo(url: self.calendars! ,valueCall: "calendars" ,valueKey:  "calendars");
        self.CallAlomo(url: self.month_calendars!,valueCall: "month_calendars",valueKey: "month_calendars");
        self.CallAlomo(url: self.typs! ,valueCall: "typs",valueKey: "typs");
        self.CallAlomo(url: self.category_typs!,valueCall: "category_typs",valueKey: "category_typs");
        self.CallAlomo(url: self.telephones! ,valueCall: "telephones",valueKey: "telephones");
        self.CallAlomo(url: self.emails!,valueCall: "emails",valueKey: "emails");
        self.CallAlomo(url: self.managements! ,valueCall: "managements",valueKey: "managements");
        self.CallAlomo(url: self.category_managements!,valueCall: "category_managements",valueKey: "category_managements");
        self.CallAlomo(url: self.feedings! ,valueCall: "feedings",valueKey: "feedings");
        self.CallAlomo(url: self.transports!,valueCall: "transports",valueKey: "transports");
        self.CallAlomo(url: self.shifts! ,valueCall: "shifts",valueKey: "shifts");
        self.CallAlomo(url: self.schedules!,valueCall: "schedules",valueKey: "schedules");
        self.CallAlomo(url: self.places! ,valueCall: "places",valueKey: "places");
        
        
        
    }
    
    
    func CallAlomo(url:String, valueCall:String, valueKey: String){
        
        SVProgressHUD.show(withStatus: "Carregando - \(valueKey)")
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
                SVProgressHUD.dismiss()
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                //debugPrint(response)
                self.parseData(JSONData: response.data!,value:valueCall, chave: valueKey)
        }

        
//        Alamofire.request(url).responseJSON(completionHandler: {
//            response in
//            self.parseData(JSONData: response.data!,value:valueCall, chave: valueKey)
//            
//        });
        
    }
    
    func parseData(JSONData: Data, value:String, chave:String){
        //SVProgressHUD.show(withStatus: "Carregando")
        let carregamento = UserDefaults.standard.object(forKey: chave) as? NSDictionary
        let methodStart = Date()
        do{
            let json = try JSONSerialization.jsonObject(with: JSONData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            //print(json)
            
            if json != carregamento {
                //URLCache.shared.removeAllCachedResponses()
                print("Pegando do servidor")
                switch value {
                case "buildings":
                    print("buildings")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "benefits":
                    print("benefits")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "abouts":
                    print("abouts")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "calendars":
                    print("calendars")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "month_calendars":
                    print("month_calendars")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "typs":
                    print("typs")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "category_typs":
                    print("category_typs")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "telephones":
                    print("telephones")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "emails":
                    print("emails")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "managements":
                    print("managements")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "category_managements":
                    print("category_managements")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "feedings":
                    print("feedings")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "transports":
                    print("transports")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "shifts":
                    print("shifts")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "schedules":
                    print("schedules")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                case "places":
                    print("places")
                    UserDefaults.standard.set(json, forKey: chave)
                    
                default:
                    print("Padrao")
                    
                }
                
            } else{
                print("Carregando da memoria")
                switch value {
                case "buildings":
                    print("buildings")
                    
                case "benefits":
                    print("benefits")
                    
                case "abouts":
                    print("abouts")
                    
                case "calendars":
                    print("calendars")
                    
                case "month_calendars":
                    print("month_calendars")
                    
                case "typs":
                    print("typs")
                    
                case "category_typs":
                    print("category_typs")
                    
                case "telephones":
                    print("telephones")
                    
                case "emails":
                    print("emails")
                    
                case "managements":
                    print("managements")
                    
                case "category_managements":
                    print("category_managements")
                    
                case "feedings":
                    print("feedings")
                    
                case "transports":
                    print("transports")
                    
                case "shifts":
                    print("shifts")
                    
                case "schedules":
                    print("schedules")
                    
                case "places":
                    print("places")
                    
                default:
                    print("Padrao")
                }
                
                
            }
            
        }catch{
            print(error)
        }
        
        let methodFinally = Date()
        let execulteTime = methodFinally.timeIntervalSince(methodStart)
        print(execulteTime)
        //SVProgressHUD.dismiss()
        
    }
    

}
