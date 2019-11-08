//
//  pokemonModel.swift
//  pokedex
//
//  Created by sasedeveMac on 08/11/19.
//  Copyright © 2019 NeuAlto. All rights reserved.
//

import Foundation

class PokemonModel {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return  _pokedexId
    }

    init( name: String!, pokedexId:  Int!){
    
        self._name = name
        self._pokedexId = pokedexId
        
    }

}
