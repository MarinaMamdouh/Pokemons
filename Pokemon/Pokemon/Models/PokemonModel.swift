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
    var url:URL
    // get id from pokemon's url
    func getId()->Int{
          let urlString = self.url.absoluteString
          let parts = urlString.split(separator: "/")
          let idString = parts.last ?? "-1"
          let id = Int(idString) ?? -1
          return id
    }
}
