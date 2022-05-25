//
//  EvolutionNodeView.swift
//  Pokemon
//
//  Created by Marina on 23/05/2022.
//

import UIKit

class EvolutionNodeView:UIView{
    
    var name:String = "Test"
    var imageId:Int? = 1
    private var image = UIImage(named: "no image")!
    private var nodeView:UIView!
    private var nodeStackView:UIStackView!
    private var nameLabel:UILabel!
    private var pokemonImage:UIImageView!
    private var arrowImage:UIImageView!
    private var vStackView:UIStackView!
    public var isLastNode:Bool = false
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawNode()
        drawArrow()
        addToStackView()
        
    }
    
    
    
    private func drawNode(){
        drawImage()
        drawNodeName()
        
        //Intiate Node View
        nodeView = UIView()
        nodeView.layer.cornerRadius = 70
        nodeView.clipsToBounds =  true
        nodeView.layer.borderWidth = 3
        nodeView.layer.borderColor = UIColor.black.cgColor
        
        // Intiate Node Stack view
        nodeStackView = UIStackView()
        nodeStackView.axis  = NSLayoutConstraint.Axis.vertical
        nodeStackView.distribution  = UIStackView.Distribution.fill
        nodeStackView.alignment = UIStackView.Alignment.center
        nodeStackView.spacing = 0
        
        
        nodeStackView.addArrangedSubview(pokemonImage)
        nodeStackView.addArrangedSubview(nameLabel)
        nodeStackView.translatesAutoresizingMaskIntoConstraints = false

        let widthConstraint = NSLayoutConstraint(item: nodeView!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 140)
        let heightConstraint = NSLayoutConstraint(item: nodeView!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 140)
        NSLayoutConstraint.activate([ widthConstraint, heightConstraint])
        nodeView.addSubview(nodeStackView)
        nodeView.backgroundColor = .gray
        nodeStackView.centerXAnchor.constraint(equalTo: nodeView.centerXAnchor).isActive = true
    }
    
    private func drawImage(){
        loadImage()
        pokemonImage =  UIImageView(image: image)
        pokemonImage.contentMode = .scaleAspectFit
        pokemonImage.clipsToBounds =  true
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: pokemonImage!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        let heightConstraint = NSLayoutConstraint(item: pokemonImage!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([ widthConstraint, heightConstraint])
    }
    
    private func drawNodeName(){
        nameLabel = UILabel()
        nameLabel.text = name
    }
    
    
    private func drawArrow(){
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 40)
        let arrow  = UIImage(systemName: "arrow.down", withConfiguration: symbolConfig)
        
        arrowImage =  UIImageView(image: arrow)
        arrowImage.tintColor = .black
        arrowImage.frame =  CGRect(x: 0, y: 0, width: 100, height: 100)

        
    }
    
    private func addToStackView(){
        //Stack View
        vStackView   = UIStackView()
        vStackView.axis  = NSLayoutConstraint.Axis.vertical
        vStackView.distribution  = UIStackView.Distribution.fill
        vStackView.alignment = UIStackView.Alignment.center
        vStackView.spacing   = 0

        vStackView.addArrangedSubview(nodeView)
        if !isLastNode{
            vStackView.addArrangedSubview(arrowImage)
        }
        vStackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(vStackView)
        
        //Constraints
        vStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        vStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    private func loadImage(){
        
        Task{
            do{
                let loader = PokemonsImageLoader()
                if let imageId = imageId {
                    let retrievedImage = try await loader.loadImage(with: imageId)
                    DispatchQueue.main.async { [weak self] in
                        self?.pokemonImage.image = retrievedImage
                    }
                }
            }
            catch{
                print(error)
            }
        }
    }
}
