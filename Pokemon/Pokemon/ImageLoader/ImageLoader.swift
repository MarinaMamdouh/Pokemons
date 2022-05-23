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
    
// load image by pokemon Id from server
    func loadImage(with pokemonId:Int) async throws -> UIImage {

        let imageHandler =  ImageHandler()
        // add the id to the pokemon image api url
        return try await imageHandler.request(route: APIRoute.getImage(pokemonId))
    }


}
