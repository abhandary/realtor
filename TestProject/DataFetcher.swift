//
//  DataFetcher.swift
//  TestProject
//
//  Created by Sanchay Banerjee on 2021-12-01.
//

import Foundation

/// Parameters for completion:
/// 1. Complete function definition for `fetchPeople`
/// 2. Handle errors

class DataFetcher {
  
  private var session: NetworkSession
  private var decoder: JSONDecodable
  
  let TAG = "DataFetcher"
  
  private let api: API = .people
  static let shared = DataFetcher()
  
  init(session: NetworkSession = URLSession(configuration: .default), decoder: JSONDecodable = CustomDecoder()) {
    self.session = session
    self.decoder = decoder
  }
}

extension URLSession : NetworkSession {
  public func loadData(from endPoint: EndPoint, completion: NetworkCompletion?) {
    
    guard let request = endPoint.request else {
      print("nil request in end point")
      completion?(.failure(NetworkError.genericNetworkError))
      return
    }
    
    self.dataTask(with: request) { data, urlResponse, error in
      if let error = error {
        print("got a network error - \(error)")
        completion?(.failure(NetworkError.genericNetworkError))
        return
      }
      guard let data = data else {
        print("got empty data from network call")
        completion?(.failure(NetworkError.genericNetworkError))
        return
      }
      completion?(.success(data))
    }.resume()
  }
}

enum DataFetcherError : Error {
  case decodingError
}

extension DataFetcher {
  typealias ResultCompletion = (Result<PeopleModel, Error>) -> Void
  
  func fetchPeople(completion: @escaping ResultCompletion) {
    self.session.loadData(from: api) { [weak self] result in
      guard let self = self else {
        print("self is nil")
        return
      }
      switch (result) {
      case .success(let data):
        print(data)
        if let people = self.decodePeople(data: data) {
          completion(.success(people))
        } else {
          completion(.failure(DataFetcherError.decodingError))
        }
      case .failure(let error):
        print("fetchPeople: got an error - \(error)")
        completion(.failure(error))
      }
    }
  }
  
  private func decodePeople(data: Data) -> PeopleModel? {
    return self.decoder.decode(type: PeopleModel.self, from: data)
  }
}
