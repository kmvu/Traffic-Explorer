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

public protocol AnyError: Error {}

public enum APIError: AnyError {
	case apiError(code: Int, message: String)
	case unkown
}
