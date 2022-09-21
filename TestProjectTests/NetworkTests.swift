//
//  NetworkTests.swift
//  TestProjectTests
//
//  Created by Banerjee, Sanchay on 7/14/22.
//

import XCTest
import TestProject

class NetworkTests: XCTestCase {

    func testLoadDataWithEndPointHavingInvalidRequest() {
        let endPoint = MockEndPoint.invalidEndPoint
        
        let sutUrlSession = URLSession(configuration: .mock)
    }
    
    /// Test successful return of data
    func testLoadDataWithEndPointHavingValidRequest() {
        let endPoint = MockEndPoint.mockEndPoint(path: "https://www.msn.com") { _ in
            let data = "Hello".data(using: .utf8)
            return (HTTPURLResponse(), data!)
        }
        
        let sutUrlSession = URLSession(configuration: .mock)
    }
}
