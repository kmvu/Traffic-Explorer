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
	
	public func getURLComponents(path: String) -> URLComponents? {
		guard let url = URL(string: "\(apiHost.absoluteString)\(path)") else { return nil }
		return URLComponents(url: url, resolvingAgainstBaseURL: false)!
	}
}

public extension HTTPURLResponse {
	var isValidStatusCode: Bool {
		(200..<300) ~= statusCode
	}
}
