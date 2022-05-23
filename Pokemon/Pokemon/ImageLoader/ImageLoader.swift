//
//  ImageLoader.swift
//  CataPoke
//
//  Created by Marina on 11/05/2022.
//

import Foundation
import SwiftUI

class PokemonsImageLoader:ImageLoading{

    
    typealias T = Int
    

    func loadImage(with pokemonId:Int) async throws -> UIImage {

        let imageHandler =  ImageHandler()
        return try await imageHandler.request(route: APIRoute.getImage(pokemonId))
    }


}
