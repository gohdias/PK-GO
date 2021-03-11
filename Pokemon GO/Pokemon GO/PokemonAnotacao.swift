//
//  PokemonAnotacao.swift
//  Pokemon GO
//
//  Created by Igor Ferreira Dias on 11/03/21.
//

import UIKit
import MapKit

class PokemonAnotacao: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    init(coordenadas: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordenadas
        self.pokemon = pokemon
    }
    
}
