//
//  ModelsTests.swift
//  TestProjectTests
//
//  Created by Banerjee, Sanchay on 7/14/22.
//

import XCTest
import TestProject

@testable import TestProject

class ModelsTests: XCTestCase {
  
  static let json = #"""
    {
        "result":[
            {"id":1,"first_name":"Jeanette","last_name":"Penddreth","email":"jpenddreth0@census.gov","gender":"Female","ip_address":"26.58.193.2"},
            {"id":2,"first_name":"Giavani","last_name":"Frediani","email":"gfrediani1@senate.gov","gender":"Male","ip_address":"229.179.4.212"},
            {"id":3,"first_name":"Noell","last_name":"Bea","email":"nbea2@imageshack.us","gender":"Female","ip_address":"180.66.162.255"},
            {"id":4,"first_name":"Willard","last_name":"Valek","email":"wvalek3@vk.com","gender":"Male","ip_address":"67.76.188.26"}
            ]
    }
    """#
  
  var data: Data!
  
  override func setUpWithError() throws {
    /// Construct data from the `json` literal
    data = ModelsTests.json.data(using: .utf8)
  }
  
  override func tearDownWithError() throws {
    
  }
  
  func testDecodingPeopleModelFromData() throws {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    let people = try jsonDecoder.decode(PeopleModel.self, from: data)

    XCTAssertEqual(people.result.count, 4)
  }
  
  func testDecodingPeopleModelResultFromData() throws {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    let people = try jsonDecoder.decode(PeopleModel.self, from: data)

    XCTAssertEqual(people.result.count, 4)
  }
  
  func testDecodingPersonModelFromData() throws {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    let people = try jsonDecoder.decode(PeopleModel.self, from: data)

    XCTAssertEqual(people.result.count, 4)
    let person = people.result[0]
    XCTAssertEqual(person.firstName, "Jeanette")
  }
}
