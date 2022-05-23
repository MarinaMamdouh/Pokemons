//
//  PokemonCellView.swift
//  Pokemon
//
//  Created by Marina on 23/05/2022.
//

import UIKit

class PokemonCellView: UITableViewCell{
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var pokemonName: UILabel!
    
    private var pokemon:PokemonModel!{
        didSet{
            if let pokemon = pokemon{
                pokemonName.text = pokemon.name
                // load image
            }
        }
    }
    
    func set(with pokemon:PokemonModel){
        self.pokemon = pokemon
    }
    
}
