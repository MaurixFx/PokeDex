//
//  ViewController.swift
//  PokeDex
//
//  Created by Mauricio Figueroa Olivares on 14-05-17.
//  Copyright © 2017 Mauricio Figueroa Olivares. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionview : UICollectionView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    // Creamos un array de Pokemones
    var pokemon = [Pokemon]()
    
    // Creamos un array de los resultados de busqueda
    var filterPokemon = [Pokemon]()
    // Variable para saber si esta en busqueda o no
    var inSearchMode = false
    
    
    // Declaramos un audioPlayer
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
       // let charmander = Pokemon(name: "Charmander", pokedexId: 4)
    
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.backgroundColor = UIColor.clear
        
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        self.parsePokemonCSV()
        
        // Iniciamos el audio
        self.initAudio()
        
    }
    
    
    func initAudio() {
        // Declaramos la ruta del archivo de musica
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            // Leemos el archivo de musics y lo asignamos al reproductor
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch (let error as NSError) {
            print(error.localizedDescription)
        }
        
        
    }
    
    
    func parsePokemonCSV() {
        // Declaramos la ruta para el archivo csv
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        
        do {
        
           // Leemos el archivo CSV de la ruta
           let csv = try CSV(contentsOfURL: path!)
           let rows = csv.rows
            
            // Recorremos las filas del archivo csv
            for row in rows {
                // Asignamos los datos
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                // Creamos un objeto Pokemon con los datos
                let pokemon = Pokemon(name: name, pokedexId: pokeId)
                //Agregamos el pokemon al array
                self.pokemon.append(pokemon)
            }
            
            
        } catch (let error as NSError) {
            print(error.localizedDescription)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Funcion donde configuramos la celda del CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            // Si estamos en modo busqueda tomamos el array de resultados
            if inSearchMode {
                poke = self.filterPokemon[indexPath.row]
                // Llamamos la funcion donde asignamos los datos de la celda
                cell.configureCell(poke)
            } else {
                
                // Asignamos la fila del array de Pokemones
                poke = self.pokemon[indexPath.row]
                // Llamamos la funcion donde asignamos los datos de la celda
                cell.configureCell(poke)
            }

            return cell
        } else {
            return UICollectionViewCell()
        }

        
        
    }
    
    // Funcion que obtiene el objeto seleccionado en la collection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = self.filterPokemon[indexPath.row]
        } else {
            poke = self.pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "showDetailPokemon", sender: poke)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Si esta en modo busqueda se toma la cantidad de resultados de busqueda
        if inSearchMode {
            return self.filterPokemon.count
        } else {
            return self.pokemon.count
        }
 
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Retornamos el tamaño de la celda
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 105, height: 105)
    }

    
    
    @IBAction func musicButton(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    // Funciones del searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionview.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            
            // obtenemos el texto de la barra de busqueda en mayuscula
            let lower = searchBar.text!.lowercased()
        
            // Asignamos el resultado del filtro a nuestro array de resultados
            filterPokemon = pokemon.filter({$0._name.range(of: lower) != nil})
        
            // Recargamos
            collectionview.reloadData()
            
            
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailPokemon" {
            if let detailsVC = segue.destination as? DetailPokemonViewController {
                
                // Si podemos asignar el objeto Pokemon a la variable
                if let poke = sender as? Pokemon {
                    
                    // Asignamos el objeto pokemon al objeto destino de la vista de detalles
                    detailsVC.pokemon = poke
                }
                
            }
            
        }
    }

}

