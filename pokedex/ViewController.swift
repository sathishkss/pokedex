//
//  ViewController.swift
//  pokedex
//
//  Created by sasedeveMac on 07/11/19.
//  Copyright © 2019 NeuAlto. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonArray = [PokemonModel]()
    var filterPokemonArray  =  [PokemonModel]()
    
    var musicPlayer: AVAudioPlayer!
    var isFilterMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        
        parsePokemonCSV()
        
        initAudio()
        
        searchBar.returnKeyType =  UIReturnKeyType.done
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //__________________________________
    
    @IBAction func musicBtn(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.5
        
        }else{
        
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    
    func initAudio(){
    
        //let path = Bundle.main.path(forResource: "firered_00AC", ofType: "wav")!
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do{
            try musicPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }catch let err as NSError{
            
            print(err.debugDescription)
        }
    
    }
    
    
    func parsePokemonCSV(){
    
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            print(rows)
            
            for row in rows {
            
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke =  PokemonModel(name: name, pokedexId: pokeId)
                
                pokemonArray.append(poke)
                
                
                
            }
        
        } catch let err as  NSError {
        
            print(err.debugDescription)
        }
    
    
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell{
        
            //let pokemonModel = PokemonModel(name: "Pokemon", pokedexId: indexPath.row)
            let pokemonModel:PokemonModel!
            
            
            if isFilterMode {
                pokemonModel = filterPokemonArray[indexPath.row]
            }else{
                pokemonModel = pokemonArray[indexPath.row]
            }
            
            cell.configurePokemonCell(pokemonModel)
            
            return cell
        
        }else{
            
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        
        var poke: PokemonModel!
        
        if isFilterMode {
            poke = filterPokemonArray[indexPath.row]
        }else{
            poke = pokemonArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isFilterMode){
        
            return filterPokemonArray.count
        }
        return pokemonArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        if((searchBar.text == nil) || (searchBar.text == "")){
        
            isFilterMode = false
            collectionView.reloadData()
            
            view.endEditing(true)

        
        }else{
            
            isFilterMode  =  true
            
            let lower = searchBar.text!.lowercased()
            
            filterPokemonArray  = pokemonArray.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
        
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? PokemonModel {
                    
                    detailsVC.pokemonModel = poke
                
                }
            }
        }
        
    }
    

}

