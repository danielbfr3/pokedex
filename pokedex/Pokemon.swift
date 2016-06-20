//
//  Pokemon.swift
//  pokedex
//
//  Created by Daniel Freire on 16/06/16.
//  Copyright © 2016 Daniel Freire. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        return _description
    }
    
    var type: String {
        return _type
    }
    
    var defense: String {
        return _defense
    }
    
    var height: String {
        return _height
    }
    
    var weight: String {
        return _weight
    }
    
    var attack: String {
        return _attack
    }
    
    var nextEvolutionText: String {
        return _nextEvolutionText
    }
    
    var nextEvolutionId: String {
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        return _nextEvolutionLevel
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(BASE_URL)\(POKEMON_URL)\(self._pokedexId)"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
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
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    var typeDesc: String = ""
                    
                    for i in 0...types.count - 1 {
                        if i == 0 {
                            if let name = types[i]["name"] {
                                typeDesc.appendContentsOf("\(name.capitalizedString)")
                            }
                        } else {
                            if let name = types[i]["name"] {
                                typeDesc.appendContentsOf("/\(name.capitalizedString)")
                            }
                        }
                    }
                    self._type = typeDesc
                }
                
                if let pokemonDescriptionArray = dict["descriptions"] as? [Dictionary<String, String>] where pokemonDescriptionArray.count > 0 {
                    
                    if let resourceUri = pokemonDescriptionArray[0]["resource_uri"] {
                        let descriptionResourceUrl = NSURL(string: "\(BASE_URL)\(resourceUri)")!
                        
                        Alamofire.request(.GET, descriptionResourceUrl).responseJSON { descriptionResponse in
                            let descriptionResult = descriptionResponse.result
                            
                            if let descDict = descriptionResult.value as? Dictionary<String, AnyObject> {
                                if let pokemonDescription = descDict["description"] as? String {
                                    self._description = pokemonDescription
                                }
                            }
                        }
                    } else {
                        self._description = ""
                    }
                    
                    
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolutionId = num
                                self._nextEvolutionText = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLevel = "\(lvl)"
                                }
                                
                                print(" \(self._nextEvolutionLevel) \(self._nextEvolutionText) \(self._nextEvolutionId) ")
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
        }
    }
}




