//
//  pokemonModel.swift
//  pokedex
//
//  Created by sasedeveMac on 08/11/19.
//  Copyright © 2019 NeuAlto. All rights reserved.
//

import Foundation
import Alamofire

class PokemonModel {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _discription: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _evoluationTitle:String!
    private var _pokemonUrl: String!
    
    var type: String {
        if _type == nil {
            _type =  ""
        }
        return _type
    }
    
    var discription: String {
        if _discription == nil {
            _discription =  ""
        }
        return _discription
    }
    
    var weight: String {
        if _weight == nil {
            _weight =  ""
        }
        return _weight
    }
    
    var height: String {
        if _height  == nil {
            _height  = ""
        }
        return _height
    }
    
    var defense: String {
        if _defense == nil{
            _defense =  ""
        }
        return _defense
    }
    
    var baseAttack: String {
        if _baseAttack == nil{
            _baseAttack = ""
        }
        return _baseAttack
    
    }
    
    
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return  _pokedexId
    }

    init( name: String!, pokedexId:  Int!){
    
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonUrl = "\(BASE_URL)\(POKEMON_URL)\(self.pokedexId)/"
        
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadCompleted){
    
        Alamofire.request(_pokemonUrl).responseJSON{ response in
        
        
            print(response.result)
            print("________________________________________")
            //print(response.result.value)
            
            if let dic = response.result.value as? Dictionary<String, AnyObject>{
                
                if let weightStr = dic["weight"] as? Int {
                    self._weight  =  "\(weightStr)"
                }
                if let heightStr = dic["height"] as? Int  {
                    self._height = "\(heightStr)"
                }
                //if let defenseInt = dic["defense"] as? Int {
                //    self._defense = "\(defenseInt)"
                //}
                if let attackInt = dic["base_experience"] as? Int {
                    self._baseAttack = "\(attackInt)"
                }
            
                print(self._weight)
                print(self._height)
                //print("\(self._defense)")
                print(self._baseAttack)
                
                if let typesArray = dic["types"] as? [Dictionary<String, AnyObject>]{
                    print("\(typesArray.count)")
                    for x in 0..<typesArray.count{
                    
                        
                        
                        if let TypeDic = typesArray[x]["type"] as? Dictionary<String, AnyObject>{
                            
                            if(self._type == nil || self._type == ""){
                                if let name = TypeDic["name"] as? String  {
                                   
                                    self._type = "\(name.capitalized)"
                                }
                                
                            }else{
                                
                                if let name = TypeDic["name"] as? String  {
                                    
                                    //self._type = "\(name.capitalized)"
                                    self._type = "\(self._type!) / \(name.capitalized)"
                                }
                                
                            }
                        
                        }

                    
                    }
                    
                    print(self._type)
                
                }
                
                if let abilityArray = dic["abilities"] as? [Dictionary<String, AnyObject>]{
                    print("abilityArray : \(abilityArray.count)")
                    
                        
                        
                        if let abiliityDic = abilityArray[0]["ability"] as? Dictionary<String, AnyObject>{
                            
                            if let urlStr = abiliityDic["url"] as? String  {
                                
                                Alamofire.request(urlStr).responseJSON(completionHandler: {(response) in
                                
                                    if let dicDesc = response.result.value as? Dictionary<String, AnyObject>{
                                        
                                        //"effect_entries"
                                        
                                        if let descArray = dicDesc["effect_entries"] as? [Dictionary<String, AnyObject>]{
                                            print("descArray : \(descArray.count)")
                                            
                                            if let descStr = descArray[0]["effect"] as? String{
                                                
                                                self._discription = descStr
                                                print(self._discription)
                                            }
                                        }
                                        
                                    }
                                    completed()
                                })
                            }
                        }
                }
                
                
            }
            
           completed()
        }
        
    }

}
