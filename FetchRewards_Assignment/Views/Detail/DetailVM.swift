//
//  DetailVM.swift
//  FetchRewards_Assignment
//
//  Created by James Sedlacek on 3/22/22.
//

import UIKit

class DetailVM: NSObject {
    
    private var ingredients: [Ingredient] = []
    private var instructions: String = ""
    public var reloadTableViewClosure: (()->())?
    
    public func fetchDessert(id: String) async {
        let networkResponse = await NetworkingService.fetchMeal(id: id)
        
        switch networkResponse {
        case .success(let fetchedMeal):
            if let fetchedMeal = fetchedMeal {
                self.instructions = fetchedMeal.instructions ?? "No instructions available..."
                self.ingredients = parseIngredients(from: fetchedMeal)
                if let reloadTV = reloadTableViewClosure {
                    reloadTV()
                }
            }
        case .failure(let nError):
            handleNetworkErrors(nError)
        }
    }
    
    private func handleNetworkErrors(_ error: NetworkError) {
        switch error {
        case .invalidURL:
            print("invalidURL")
        case .decodingJSON:
            print("decodingJSON")
        case .noResponse:
            print("noResponse")
        case .unauthorized:
            print("unauthorized")
        case .unexpectedStatusCode:
            print("unexpectedStatusCode")
        case .unknown:
            print("unknown")
        }
    }
    
    private func parseIngredients(from meal: Meal) -> [Ingredient] {
        var ingredients: [Ingredient] = []
        ingredients.append(Ingredient(name: meal.ingredient1,
                                      measurement: meal.measurement1))
        ingredients.append(Ingredient(name: meal.ingredient2,
                                      measurement: meal.measurement2))
        ingredients.append(Ingredient(name: meal.ingredient3,
                                      measurement: meal.measurement3))
        ingredients.append(Ingredient(name: meal.ingredient4,
                                      measurement: meal.measurement4))
        ingredients.append(Ingredient(name: meal.ingredient5,
                                      measurement: meal.measurement5))
        ingredients.append(Ingredient(name: meal.ingredient6,
                                      measurement: meal.measurement6))
        ingredients.append(Ingredient(name: meal.ingredient7,
                                      measurement: meal.measurement7))
        ingredients.append(Ingredient(name: meal.ingredient8,
                                      measurement: meal.measurement8))
        ingredients.append(Ingredient(name: meal.ingredient9,
                                      measurement: meal.measurement9))
        ingredients.append(Ingredient(name: meal.ingredient10,
                                      measurement: meal.measurement10))
        ingredients.append(Ingredient(name: meal.ingredient11,
                                      measurement: meal.measurement11))
        ingredients.append(Ingredient(name: meal.ingredient12,
                                      measurement: meal.measurement12))
        ingredients.append(Ingredient(name: meal.ingredient13,
                                      measurement: meal.measurement13))
        ingredients.append(Ingredient(name: meal.ingredient14,
                                      measurement: meal.measurement14))
        ingredients.append(Ingredient(name: meal.ingredient15,
                                      measurement: meal.measurement15))
        ingredients.append(Ingredient(name: meal.ingredient16,
                                      measurement: meal.measurement16))
        ingredients.append(Ingredient(name: meal.ingredient17,
                                      measurement: meal.measurement17))
        ingredients.append(Ingredient(name: meal.ingredient18,
                                      measurement: meal.measurement18))
        ingredients.append(Ingredient(name: meal.ingredient19,
                                      measurement: meal.measurement19))
        ingredients.append(Ingredient(name: meal.ingredient20,
                                      measurement: meal.measurement20))
        ingredients = ingredients.filter({$0.name != nil && !$0.name!.isEmpty})
        return ingredients
    }
}

// MARK: DataSource

extension DetailVM: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Instructions" : "Ingredients"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionsCell", for: indexPath) as? InstructionsCell else { return UITableViewCell() }
            cell.instructionsTextView.text = instructions
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientCell else { return UITableViewCell() }
            cell.configure(with: ingredients[indexPath.row])
            return cell
        }
    }
    
}
