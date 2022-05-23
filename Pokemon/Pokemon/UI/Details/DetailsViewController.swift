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
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonImage.image = image
    }
}
