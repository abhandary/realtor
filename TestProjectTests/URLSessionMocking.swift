//
//  NetworkLayerMocking.swift
//  TestProjectTests
//
//  Created by Banerjee, Sanchay on 8/8/22.
//

import Foundation
import XCTest

extension URLSessionConfiguration {
    static var mock: URLSessionConfiguration = {
        let isRegistered = URLProtocol.registerClass(MockURLProtocol.self)
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return config
    }()
}

/// We're here validating the idea of invoking decode
/// Whether the decode function in MockJSONDecoder is going ot be called
/// or the one defined in the extension
/// let ob1 = MockJSONDecoder()
/// let ob2: JSONDecodable = MockJSONDecoder()


class MockURLProtocol: URLProtocol {

    typealias RequestHandler = (URLRequest) throws -> (HTTPURLResponse?, Data?)
    
    class func mock(request: NSMutableURLRequest, requestHandler: @escaping RequestHandler) {
        setProperty(requestHandler, forKey: keyRequestHandler, in: request)
    }
    
    private static let keyRequestHandler = "RequestHandler"
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let handler = Self.property(forKey: Self.keyRequestHandler, in: request) as? RequestHandler else {
            XCTFail("you forgot to set the mock protocol request handler")
            return
        }
        do {
            let (response, data) = try handler(request)
            if let response = response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
            }
            self.client?.urlProtocolDidFinishLoading(self)
        } catch {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }
    override func stopLoading() {} // not interested
}
