//
//  ApiResponse.swift
//  FetchRewards_Assignment
//
//  Created by James Sedlacek on 3/22/22.
//

import Foundation

struct ApiResponse: Decodable {
    let meals: [Meal]
}
