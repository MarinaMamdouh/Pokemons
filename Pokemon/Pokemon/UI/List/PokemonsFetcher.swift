//
//  PokemonsFetcher.swift
//  Pokemon
//
//  Created by Marina on 25/05/2022.
//

import Foundation

class PokemonsFetcher{
    func fetchPokemons(limit:Int, offset:Int) async throws -> [PokemonModel] {
        let requestHandler = RequestHandler()
        let list:PokemonListModel = try await requestHandler.request(route: APIRoute.getPokemonsList(limit: limit, offset: offset))
        return list.results
    }
}
