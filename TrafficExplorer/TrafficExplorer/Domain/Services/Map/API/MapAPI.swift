//
//  MapAPI.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation
import Combine

// MARK: - API Calls

public extension AnyAPI {
	func trafficData(completion: @escaping (TrafficResponse?, Error?) -> Void) {
		guard let request = getURLComponents().request(method: .POST) else { return }
		
		session.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(nil, error)
			} else if let data = data,
				let response = response as? HTTPURLResponse, response.isValidStatusCode {
				DispatchQueue.main.async {
					do {
						let trafficResponse = try JSONDecoder().decode(TrafficResponse.self, from: data)
						completion(trafficResponse, nil)
					} catch {
						completion(nil, error)
					}
				}
			}
		}
		
		// TODO: try this later
//		let agent = Agent<TrafficResponse>()
//		return agent.run(request)
	}
}

// MARK: - Helpers

typealias Parameter = (name: String, value: String)

extension URLComponents {
    func request(method: Constants.HTTPMethod,
                 params: [Parameter] = []) -> URLRequest? {
        url.map {
            var request = URLRequest(url: $0)
            request.httpMethod = method.rawValue
            
            return request
        }
    }
}

private extension String {
	var url: URL? { URL(string: self, relativeTo: Constants.baseURL) }
}
