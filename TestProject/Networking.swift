//
//  Networking.swift
//  TestProject
//
//  Created by Sanchay Banerjee on 2021-12-01.
//

import Foundation

/// Parameters for completion:
/// 1. Complete implementation of necessary network functionality
/// 2. Handle errors
/// Note: For all network error scenarios, use `genericNetworkError`

//MARK: - Endpoint

public protocol EndPoint {
    var path: String { get }
    var request: URLRequest? { get }
}

enum API {
    case people
}

extension API: EndPoint {
    var path: String {
        switch self {
        case .people:
            return "https://mocki.io/v1/7592d108-5a26-49b7-81da-4334281b8005"
        }
    }
    
    var request: URLRequest? {
        guard let url = URL(string: path) else { return nil }
        return URLRequest(url: url)
    }
}

//MARK: - NetworkError

public enum NetworkError: Error {
    case genericNetworkError
}

extension NetworkError {
    
    var localizedDescription: String {
        switch self {
        case .genericNetworkError:
            return "Generic Network Error"
        }
    }
}

//MARK: - NetworkSession

public typealias NetworkCompletion = (Result<Data, Error>) -> Void

public protocol NetworkSession {
    func loadData(from endPoint: EndPoint, completion: NetworkCompletion?)
}
