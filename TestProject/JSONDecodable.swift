//
//  JSONDecodable.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation
import UIKit

enum JSONError: Error {
    case invalid
}

public protocol JSONDecodable {}

extension JSONDecodable {
    
    func decode<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data else { return nil }
        
        var decodedData: T?
        do {
            decodedData = try decoder.decode(type, from: data)
        } catch let DecodingError.keyNotFound(key, context) {
            print("\(key) not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("\(value) not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("\(type) incorrect:", context.debugDescription)
            print("codingPath:", context.codingPath)
        }
        catch (let error) {
            print(error)
        }
        
        return decodedData
    }
}
