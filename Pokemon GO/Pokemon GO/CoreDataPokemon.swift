//
//  CoreDataPokemon.swift
//  Pokemon GO
//
//  Created by Igor Ferreira Dias on 11/03/21.
//

import UIKit
import CoreData

class CoreDataPokemon{
    
    //recuperar o context
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
        
    }
    //adicionar todos os pokemons
    func adicionarTodosPokemons(){
        
        let context = self.getContext()
        
        self.criarPokemon(nome: "Mew", nomeImagem:"mew", capturado: false)
        self.criarPokemon(nome: "Pikachu", nomeImagem:"pikachu-2", capturado: true)
        
        do {
            try context.save()
        } catch  {
            // nada
        }
        
    }
    //criar os pokemons
    func criarPokemon(nome: String, nomeImagem: String, capturado: Bool){
        
        let context = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomeImagem = nomeImagem
        pokemon.capturado = capturado
    }
}
