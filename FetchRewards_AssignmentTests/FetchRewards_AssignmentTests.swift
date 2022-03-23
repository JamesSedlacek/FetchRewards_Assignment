//
//  FetchRewards_AssignmentTests.swift
//  FetchRewards_AssignmentTests
//
//  Created by James Sedlacek on 3/22/22.
//

import XCTest
@testable import FetchRewards_Assignment

class FetchRewards_AssignmentTests: XCTestCase {

    func testFetchingDesserts() async throws {
        let networkResponse = await NetworkingService.fetchMeals(filter: "Dessert")
        switch networkResponse {
        case .success(let desserts):
            XCTAssert(!desserts.isEmpty)
        case .failure(_):
            XCTAssert(false)
        }
    }
    
    func testFetchingWithId() async throws {
        let networkResponse = await NetworkingService.fetchMeal(id: "53049")
        switch networkResponse {
        case .success(let dessert):
            XCTAssert(dessert != nil)
        case .failure(_):
            XCTAssert(false)
        }
    }

}
