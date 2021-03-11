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
    var contador = 0
    var coreDataPokemon: CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        //recuperar pokemons
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = self.coreDataPokemon.recuperarTodosPokemons()
        
        
        //Exibir pokemons
        Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { (timer) in
            
            if let coordenadas = self.gerenciadorLocalizacao.location?.coordinate{
                
                let totalPokemons = UInt32(self.pokemons.count)
                let indicePokemonAleatorio =  arc4random_uniform(totalPokemons)
                
                let pokemon = self.pokemons[Int(indicePokemonAleatorio)]
                
                let anotacao = PokemonAnotacao(coordenadas: coordenadas, pokemon: pokemon)
                let latAleatoria = (Double(arc4random_uniform(300))-150) / 100000.0
                let longAleatoria = (Double(arc4random_uniform(300))-150) / 100000.0
                
                //anotacao.coordinate = coordenadas
                anotacao.coordinate.latitude += latAleatoria
                anotacao.coordinate.longitude += longAleatoria
                
                self.mapa.addAnnotation(anotacao)
            }
             
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let anotacaoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
       
        
        if annotation is MKUserLocation{
            anotacaoView.image = #imageLiteral(resourceName: "player")
        }else{
            let pokemon = (annotation as! PokemonAnotacao).pokemon
            
            anotacaoView.image = UIImage(named: pokemon.nomeImagem!)
        }
        
        var frame = anotacaoView.frame
        frame.size.height = 40
        frame.size.width = 40
        
        anotacaoView.frame = frame
        
        return anotacaoView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                
        if contador < 5{
            self.centralizar()
            contador += 1
        }else{
            gerenciadorLocalizacao.stopUpdatingLocation()
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
    
    func centralizar() {
        if let coordenadas = gerenciadorLocalizacao.location?.coordinate{
            let regiao = MKCoordinateRegion.init(center: coordenadas, latitudinalMeters: 200, longitudinalMeters: 200)
            mapa.setRegion(regiao, animated: true)
        }
    }
    
    @IBAction func centralizarJogador(_ sender: Any) {
        self.centralizar()
    }
    @IBAction func abrirPokedex(_ sender: Any) {
    }
    

}

