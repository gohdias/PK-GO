//
//  ViewController.swift
//  Pokemon GO
//
//  Created by Igor Ferreira Dias on 10/03/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordenadas = gerenciadorLocalizacao.location?.coordinate{
            
            let regiao = MKCoordinateRegion.init(center: coordenadas, latitudinalMeters: 200, longitudinalMeters: 200)
            mapa.setRegion(regiao, animated: true)
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse && status != .notDetermined{
            //alerta
            let alertController = UIAlertController(title: "Permissao de localizaçao", message: "Precisamos da sua localizacao para que os Pokemons aparecam na sua tela!", preferredStyle: .alert)
            let acaoConfiguracoes = UIAlertAction(title: "Abrir configuracoes", style: .default) { (alertaConfiguracoes) in
                
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(configuracoes as URL)
                }
            }
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
            present(alertController, animated: true, completion: nil)
            
        }
    }

}

