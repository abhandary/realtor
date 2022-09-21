//
//  Mocks.swift
//  TestProjectTests
//
//  Created by Banerjee, Sanchay on 7/14/22.
//

import Foundation
import TestProject
import XCTest

struct MockEndPoint: EndPoint {
    let path: String
    let request: URLRequest?
    
    static let invalidEndPoint = MockEndPoint(path: "", request: nil)
    static let validEndPoint = MockEndPoint(
        path: "https://www.google.com",
        request: URLRequest(
            url: URL(string: "https://www.google.com")!
        )
    )
    
    static func mockEndPoint(path: String, requestHandler: @escaping MockURLProtocol.RequestHandler) -> MockEndPoint {
        let mutableRequest = NSMutableURLRequest(url: URL(string: path)!)
        MockURLProtocol.mock(request: mutableRequest, requestHandler: requestHandler)
        return MockEndPoint(path: path, request: mutableRequest as URLRequest)
    }
}

class MockNetworkSession: NetworkSession {
    let loadDataCompletionResult: Result<Data, Error>
    private(set) var loadDataInvocationCount = 0
    
    init(_ loadDataCompletionResult: Result<Data, Error>) {
        self.loadDataCompletionResult = loadDataCompletionResult
    }
    
    public func loadData(from endPoint: EndPoint, completion: NetworkCompletion?) {
        loadDataInvocationCount += 1
        completion?(loadDataCompletionResult)
    }
}

class MockJSONDecoder: JSONDecodable {
    let decodedObject: Any
    private (set) var decodeInvocationCount = 0
    
    init(_ decodedObject: Any) {
        self.decodedObject = decodedObject
    }
    
    func decode<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        decodeInvocationCount += 1
        return decodedObject as? T
    }
}
