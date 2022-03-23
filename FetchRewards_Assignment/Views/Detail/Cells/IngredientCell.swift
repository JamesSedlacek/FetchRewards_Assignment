//
//  IngredientCell.swift
//  FetchRewards_Assignment
//
//  Created by James Sedlacek on 3/22/22.
//

import UIKit

class IngredientCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var measurementLabel: UILabel!
    
    func configure(with ingredient: Ingredient) {
        nameLabel.text = ingredient.name
        measurementLabel.text = ingredient.measurement
    }
}
