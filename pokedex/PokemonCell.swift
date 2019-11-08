//
//  PokemonCellCollectionViewCell.swift
//  pokedex
//
//  Created by sasedeveMac on 08/11/19.
//  Copyright © 2019 NeuAlto. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    @IBOutlet weak var pokeLabel: UILabel!
    
    var pokemonModel:PokemonModel!
    
    required init?(coder adecode: NSCoder){
        super.init(coder: adecode)
        
        layer.cornerRadius = 10.0
    
    }
    
    
    
    func configurePokemonCell(_ poke: PokemonModel!){
        
        self.pokemonModel = poke
        
        self.pokeLabel.text = self.pokemonModel.name
        self.thumbImg.image = UIImage(named: "\(self.pokemonModel.pokedexId)")
        
    }
    
}
