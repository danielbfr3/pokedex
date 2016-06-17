//
//  PokeCellCollectionViewCell.swift
//  pokedex
//
//  Created by Daniel Freire on 16/06/16.
//  Copyright © 2016 Daniel Freire. All rights reserved.
//

import UIKit

class PokeCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
