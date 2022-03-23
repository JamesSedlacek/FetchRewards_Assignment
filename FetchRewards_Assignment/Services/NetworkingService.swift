//
//  NetworkingService.swift
//  FetchRewards_Assignment
//
//  Created by James Sedlacek on 3/22/22.
//

import Foundation

// MARK: Error Enum

enum NetworkError: Error {
    case invalidURL
    case decodingJSON
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
}

// MARK: Service

struct NetworkingService {
    
    // MARK: Properties
    
    static private let secureProtocol = "https://"
    static private let domain = "www.themealdb.com"
    static private let path = "/api/json"
    static private let versionNum = "/v1"
    static private let apiKey = "/1"
    static private let queryFilter = "/filter.php?c="
    static private let queryId = "/lookup.php?i="
    
    // MARK: Public Functions
    
    static func fetchMeals(filter: String) async -> Result<[Meal], NetworkError> {
        let urlString = secureProtocol + domain + path + versionNum + apiKey + queryFilter + filter
        return await fetchMeals(urlString: urlString)
    }
    
    static func fetchMeal(id: String) async -> Result<Meal?, NetworkError> {
        let urlString = secureProtocol + domain + path + versionNum + apiKey + queryId + id
        let result = await fetchMeals(urlString: urlString)
        
        switch result {
        case .success(let meals):
            if meals.isEmpty { return .success(nil) }
            return .success(meals[0])
        case .failure(let nError):
            return .failure(nError)
        }
    }
    
    // MARK: Private Functions
    
    static private func fetchMeals(urlString: String) async -> Result<[Meal], NetworkError> {
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    let mealResults = try JSONDecoder().decode(ApiResponse.self, from: data)
                    return .success(mealResults.meals)
                } catch {
                    return .failure(.decodingJSON)
                }
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
