//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by sasedeveMac on 12/11/19.
//  Copyright © 2019 NeuAlto. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    
    @IBOutlet weak var labelPokeName: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var DiscriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defensseLbl: UILabel!
    @IBOutlet weak var heigttLbl: UILabel!
    @IBOutlet weak var pokeIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var EvolutionLbl: UILabel!
    @IBOutlet weak var currentImg: UIImageView!
    @IBOutlet weak var nextImg: UIImageView!
    
    var nextID: Int!
    var pokemonModel: PokemonModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let Img = UIImage(named: "\(pokemonModel.pokedexId)")!
        
        
        mainImg.image = Img
        currentImg.image =  Img
        
        //nextID = pokemonModel.pokedexId+1 as Int
        //let a:Int = pokemonModel.pokedexId
        
        nextID = pokemonModel.pokedexId+1
        
        print("pokemonModel.pokedexId_______\(pokemonModel.pokedexId)")
        print("nextID_______\(nextID!)")

        let Imgs = UIImage(named: "\(nextID!)")
        nextImg.image = Imgs
        
        pokeIDLbl.text  = "\(pokemonModel.pokedexId)"
        
        labelPokeName.text =  pokemonModel.name
        
        pokemonModel.downloadPokemonDetails {
            print("_____________Download Completed_________?????_______")
            self.updateUI()

        }
        
    }
    
    func updateUI(){
        
        weightLbl.text =  pokemonModel.weight
        defensseLbl.text =  "00"
        heigttLbl.text = pokemonModel.height
        baseAttackLbl.text = pokemonModel.baseAttack
        typeLbl.text = pokemonModel.type
        DiscriptionLbl.text = pokemonModel.discription
        
    
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    

}
