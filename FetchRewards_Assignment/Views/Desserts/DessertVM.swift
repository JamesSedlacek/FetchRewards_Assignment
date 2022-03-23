//
//  DessertVM.swift
//  FetchRewards_Assignment
//
//  Created by James Sedlacek on 3/22/22.
//

import UIKit

class DessertVM: NSObject {
    
    private var desserts: [Meal] = []
    public var reloadTableViewClosure: (()->())?
    
    public func fetchDesserts() async {
        let networkResponse = await NetworkingService.fetchMeals(filter: "Dessert")
        
        switch networkResponse {
        case .success(let fetchedMeals):
            self.desserts = fetchedMeals
            if let reloadTV = reloadTableViewClosure {
                reloadTV()
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
    
    public func getDessert(for row: Int) -> Meal {
        return desserts[row]
    }
}

// MARK: DataSource

extension DessertVM: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return desserts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DessertCell", for: indexPath) as? DessertCell else { return UITableViewCell() }
        cell.configure(with: desserts[indexPath.row])
        return cell
    }
}
