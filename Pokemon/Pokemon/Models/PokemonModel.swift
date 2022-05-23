//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Marina on 23/05/2022.
//

import Foundation

struct PokemonListModel:Codable{
    var count:Int
    var next:URL?
    var previous:URL?
    var results:[PokemonModel]
}

struct PokemonModel:Codable{
    var name:String
    var url:String
}
