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

public protocol AnyAPI {
	var apiHost: URL { get }
	var session: URLSession { get }

	func getURLComponents(path: String) -> URLComponents?
}

public enum APIError: Error {
	case apiError(code: Int, message: String)
	case unknown
}

// MARK: - Helpers

typealias Parameter = (name: String, value: String)

extension URLComponents {
	func request(method: Constants.HTTPMethod,
				 parameters: [Parameter] = []) -> URLRequest? {
		url.map {
			var request = URLRequest(url: $0,
									 cachePolicy: .useProtocolCachePolicy,
									 timeoutInterval: 60)
			request.httpMethod = method.rawValue
			return request
		}
	}
}
