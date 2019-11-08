//
//  ViewController.swift
//  pokedex
//
//  Created by sasedeveMac on 07/11/19.
//  Copyright © 2019 NeuAlto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemonArray = [PokemonModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        parsePokemonCSV()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //__________________________________
    
    
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
            let pokemonModel = pokemonArray[indexPath.row]
            cell.configurePokemonCell(pokemonModel)
            
            return cell
        
        }else{
            
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pokemonArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
    
    

}

