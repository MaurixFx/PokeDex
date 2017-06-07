//
//  DetailPokemonViewController.swift
//  PokeDex
//
//  Created by Mauricio Figueroa Olivares on 15-05-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit

class DetailPokemonViewController: UIViewController {

    
    @IBOutlet var namePokemonLabel: UILabel!
    @IBOutlet var imagePokemon: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var defenseLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var pokedexID: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var attackLabel: UILabel!
    @IBOutlet var currentEvoImage: UIImageView!
    @IBOutlet var nextEvoImage: UIImageView!
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var evoLabel: UILabel!

    // Declaramos una variable de la clase Pokemon
    var pokemon: Pokemon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.namePokemonLabel.text = pokemon.name.capitalized
    
        let image = UIImage(named: "\(self.pokemon.pokedexId)")
        
        // Asignamos la imagen del Pokemon
        self.imagePokemon.image = image
        
        self.currentEvoImage.image = image
        
        // Asignamos el id del Pokedex
        self.pokedexID.text = "\(self.pokemon.pokedexId)"
        
        // Esta funcion se ejecuta cuando se completa la descarga de la información
        pokemon.downloadPokemonDetail {
            
            
            self.updateUI()
            
        }
    
    }
    
    // Funcion que actualiza los datos en pantalla
    func updateUI() {
        
        self.typeLabel.text = self.pokemon._type
        self.attackLabel.text = self.pokemon.attact
        self.defenseLabel.text = self.pokemon.defense
        self.weightLabel.text = self.pokemon.weight
        self.heightLabel.text = self.pokemon.height
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        
        // Cerramos la actual vista
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
