//
//  DetailsViewController.swift
//  Pokemon
//
//  Created by Marina on 23/05/2022.
//

import UIKit

class DetailsViewController:UIViewController{
    
    static let identifier = "Details"
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    var image:UIImage?
    var pokemon:PokemonModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pokemon?.name
        loadImage()
    }
    
    // load image of the current pokemon from cached data
    private func loadImage(){
        let loader = PokemonsImageLoader()
        Task{
            do{
                if let pokemon = pokemon {
                    let image = try await loader.loadImage(with:pokemon.getId())
                    DispatchQueue.main.async { [weak self] in
                        self?.pokemonImage.image = image
                    }
                }
                
            }
            catch{
                // show error
                print(error)
            }
        }
    }
}
