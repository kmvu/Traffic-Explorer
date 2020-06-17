//
//  AnyAPI.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation
import Combine

// MARK: - APIs foundation

public protocol AnyAPI {}
public protocol AnyError: Error {}

public enum APIError: AnyError {
    case apiError(reason: String)
    case unkown
}

// MARK: Agents

public protocol AnyAgent {
    associatedtype T = Decodable
    func run(_ request: URLRequest) -> AnyPublisher<T, Error>
}

public struct Agent<T: Decodable>: AnyAgent {
    public func run(_ request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map { data, _ in data }
            .handleEvents(receiveOutput: {
                debugPrint(NSString(data: $0, encoding: String.Encoding.utf8.rawValue)!)
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
