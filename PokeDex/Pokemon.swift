//
//  Pokemon.swift
//  PokeDex
//
//  Created by Mauricio Figueroa Olivares on 14-05-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    var _name: String!
    var _pokedexId: Int!
    var _descripcion: String!
    var _type: String!
    var _defense: String!
    var _height: String!
    var _weight: String!
    var _attack: String!
    var _nextEvolutionTxt: String!
    var _pokemonURL: String!
    
    var description: String {
        if _descripcion == nil {
            _descripcion = ""
        }
        return _descripcion
    }
    
    
    var typr: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        
        return _weight
    }
    
    var attact: String {
        
        if _attack == nil {
            _attack = ""
        }
        
        return _attack
    }
    
    
    var nextEvolutionText: String {
        
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        
        return _nextEvolutionTxt
    }
    
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {

        // Obtenemos la respuesta de la Api de Pokemon
        Alamofire.request(self._pokemonURL).responseJSON { (response) in
            
            // Agregamos todo el resultado a un diccionario
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                // Asignamos los datos a los objetos de la clase
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                // Obtenemos un array de Types
                if let types = dict["types"] as? [Dictionary<String, String>] {
                    
                    if types.count > 0 {
                        
                        if let name = types[0]["name"] {
                            self._type = name.capitalized
                        }
                        
                        
                        if types.count > 1 {
                            
                            for x in 1..<types.count {
                                
                                if let name = types[x]["name"] {
                                    self._type! += "/\(name.capitalized)"
                                }
                                
                            }
                            
                        }

                    }
                    
                    
                    
                } else {
                    self._type = ""
                }

                
                
            }
            
            completed()
        }
        
        
    }
    
    

}
