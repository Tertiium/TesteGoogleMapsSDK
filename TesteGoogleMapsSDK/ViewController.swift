//
//  ViewController.swift
//  TesteGoogleMapsSDK
//
//  Created by user on 09/02/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject{
    
    let nome :  String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(nome: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.nome = nome
        self.location = location
        self.zoom = zoom
    }
}

class ViewController: UIViewController {

    //MARK: - Properties
    var mapView: GMSMapView?
    
    var currentDestination:VacationDestination?
    
    let destination = [VacationDestination(nome: "Local de Trabalho", location: CLLocationCoordinate2D(latitude: -23.589152, longitude: -46.645051), zoom: 15),
                       VacationDestination(nome: "MASP", location: CLLocationCoordinate2D(latitude: -23.561414, longitude: -46.655860), zoom: 15),
                       VacationDestination(nome: "Parque Ibirapuera", location: CLLocationCoordinate2D(latitude: -23.587406, longitude: -46.657623), zoom: 15)
                       ]
    
    //MARK: - Outlets
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyA3Ge0nodCGpYkE5Gm6sx2Bd_JOiaPFjd0")
        
        let camera = GMSCameraPosition.camera(withLatitude: -23.566127, longitude: -46.652515, zoom: 15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2D(latitude: -23.566127, longitude: -46.652515)
        
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Quaddro Treinamento"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.nextx) )
    }
    
    //MARK: - IBActions
    
    func nextx() {
        
        if currentDestination == nil{
            currentDestination = destination.first
        }else{
            if let index = destination.index(of: currentDestination!){
                
                if index+1 > destination.endIndex-1{
                    let alert = UIAlertController(title: "FIM DO NEXT", message: "Não existe mais endereço!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                        //self.viewDidLoad()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    currentDestination = destination[index+1]
                }

            }
        }
        setMapCamera()
    }
    
    private func setMapCamera(){
//        CATransaction.begin()
//        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
//        CATransaction.setAnimationDuration(1)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination!.nome
        marker.map = mapView
    }
    
}

