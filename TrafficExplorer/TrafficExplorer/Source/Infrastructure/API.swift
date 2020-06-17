//
//  API.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

public class API: AnyAPI {
	public var apiHost: URL
	public var session: URLSession
	
	public init(apiHost: URL, session: URLSession) {
		self.apiHost = apiHost
		self.session = session
	}
	
	public func getURLComponents() -> URLComponents {
		URLComponents(url: apiHost, resolvingAgainstBaseURL: false)!
	}
}

public extension HTTPURLResponse {
	var isValidStatusCode: Bool {
		(200..<300) ~= statusCode
	}
	
	var isValidContentType: Bool {
		guard let contentType = allHeaderFields["Content-Type"] as? String else {
			return false
		}
		return ["application/json"].contains { contentType.contains($0) }
	}
}
