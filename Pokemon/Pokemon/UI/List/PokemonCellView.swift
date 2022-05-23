//
//  PokemonCellView.swift
//  Pokemon
//
//  Created by Marina on 23/05/2022.
//

import UIKit

class PokemonCellView: UITableViewCell{
    static let identifier = "PokemonCell"
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var pokemonName: UILabel!
    
    private var pokemon:PokemonModel!{
        didSet{
            if let pokemon = pokemon{
                pokemonName.text = pokemon.name
                loadImage()
            }
        }
    }
    
    // set pokemon property
    func set(with pokemon:PokemonModel){
        self.pokemon = pokemon
    }
    
    // load image of the current pokemon from server
    private func loadImage(){
        let loader = PokemonsImageLoader()
        Task{
            do{
                let image = try await loader.loadImage(with:pokemon.getId())
                DispatchQueue.main.async { [weak self] in
                    self?.pokemonImage.image = image
                }
            }
            catch{
                // show error
                print(error)
            }
        }
    }
    
}
