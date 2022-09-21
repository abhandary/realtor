//
//  DataModel.swift
//  TestProject
//
//  Created by Sanchay Banerjee on 2021-12-01.
//

import Foundation

/// Parameters for completion:
/// 1. Complete implementation for both the models

struct PersonModel : Codable {
  let id: Int
  let firstName: String
  let lastName: String
  let email: String
  let gender: String
  let ipAddress: String
}

struct PeopleModel : Codable {
  let result: [PersonModel]
}
