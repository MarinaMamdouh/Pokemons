//
//  DetailsViewController.swift
//  Pokemon
//
//  Created by Marina on 23/05/2022.
//

import UIKit

class DetailsViewController:UIViewController{
    
    static let identifier = "Details"
    
    @IBOutlet weak var treeView: EvolutionTreeView!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    var image:UIImage?
    var pokemon:PokemonModel?
    var evolutionPokemons:[PokemonModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pokemon?.name
        loadImage()
        fetchPokemons()
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
    
    // get pokemon from server
    func fetchPokemons(){
        let requestHandler = RequestHandler()
        Task{
            do{
                let list:PokemonListModel = try await requestHandler.request(route: APIRoute.getPokemonsList(limit:3, offset: 0))
                DispatchQueue.main.async { [weak self] in
                    self?.evolutionPokemons.append(contentsOf: list.results)
                    self?.loadTree()
                }
            }
            catch{
                // show error
                print(error)
            }
        }
        
    }
    
    private func loadTree(){
        treeView.pokemons = evolutionPokemons
        treeView.setNeedsDisplay()
    }
}
