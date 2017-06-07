//
//  PokeCell.swift
//  PokeDex
//
//  Created by Mauricio Figueroa Olivares on 14-05-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var namePokeLabel: UILabel!
    
    // Declaramos una variable de la clase Pokemon
    var pokemon: Pokemon!
    
    // Esto permite que la celda tenga bordes curvos
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    
    // Funcion donde configuramos la celda
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        
        // Asignamos los datos
        namePokeLabel.text = self.pokemon._name.capitalized
        pokeImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    
    }
    
}
