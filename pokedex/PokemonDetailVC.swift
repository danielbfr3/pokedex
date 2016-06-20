//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Daniel Freire on 19/06/16.
//  Copyright © 2016 Daniel Freire. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalizedString
        mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
        currentEvolutionImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { () -> () in
            //this will be called after download is done, end "completed" is called at code
            
            self.updateUI()
        }
    }
    
    func updateUI() {
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        evolutionLabel.text = pokemon.nextEvolutionText
        
        if pokemon.nextEvolutionId == "" {
            evolutionLabel.text = "No evolutions"
            nextEvolutionImage.hidden = true
        } else {
            evolutionLabel.text = "NEXT EVOLUTION: \(pokemon.nextEvolutionText) LVL \(pokemon.nextEvolutionLevel)"
            nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionId)
            nextEvolutionImage.hidden = false
        }
    }
    
    // MARK: - Navigation

    @IBAction func backButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
