//
//  BreedCell.swift
//  CatBreed
//
//  Created by Анна Белова on 28.07.2024.
//

import UIKit

class BreedCell: UITableViewCell {
    
    @IBOutlet var breedLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var coatLabel: UILabel!
    @IBOutlet var patternLabel: UILabel!
    
    func configure(with breed: Breed) {
        breedLabel.text = "Breed: \(breed.breed)"
        countryLabel.text = "Country: \(breed.country)"
        originLabel.text = "Origin: \(breed.origin)"
        coatLabel.text = "Coat: \(breed.coat)"
        patternLabel.text = "Pattern: \(breed.pattern)"
    }
}
