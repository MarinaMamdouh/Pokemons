//
//  ViewController.swift
//  Pokemon
//
//  Created by Marina on 23/05/2022.
//

import UIKit

class ListViewController: UITableViewController {
    var pokemons:[PokemonModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemons()
        
    }
    // get pokemon from server
    func fetchPokemons(){
        let requestHandler = RequestHandler()
        Task{
            do{
                let list:PokemonListModel = try await requestHandler.request(route: APIRoute.getPokemonsList(limit: 0, offset: 20))
                DispatchQueue.main.async { [weak self] in
                    self?.pokemons.append(contentsOf: list.results)
                    self?.tableView.reloadData()
                }
            }
            catch{
                // show error
                print(error)
            }
        }
        
    }


}

extension ListViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCellView.identifier) as! PokemonCellView
        cell.set(with: pokemons[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

