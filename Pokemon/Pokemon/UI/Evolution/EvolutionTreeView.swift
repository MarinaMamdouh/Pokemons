//
//  EvolutionTreeView.swift
//  Pokemon
//
//  Created by Marina on 23/05/2022.
//

import UIKit

class EvolutionTreeView:UIView{
    var pokemons:[PokemonModel] = []
    private var stackView:UIStackView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawTree()

    }
    
    private func drawTree(){
        var previous:EvolutionNodeView?
        for pokemon in pokemons{
            let node = EvolutionNodeView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            //node.frame = stackView.frame
            node.translatesAutoresizingMaskIntoConstraints = false
            node.imageId = pokemon.getId()
            node.name = pokemon.name
            self.addSubview(node)
            node.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            if let previous = previous {
                node.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 200).isActive = true
            }else{
                node.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
            }
            
            previous = node
        }
        
    }
    
    private func removeAllSubViews(view:UIView){
        for view in view.subviews {
            view.removeFromSuperview()
        }
    }

}
