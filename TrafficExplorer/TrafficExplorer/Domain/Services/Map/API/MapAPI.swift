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
	func trafficData(completion: @escaping (TrafficResponse?, APIError?) -> Void) {
		guard let request = getURLComponents(path: "/v1/transport/traffic-images")?
			.request(method: .GET) else {
				debugPrint("Error: Invalid URL path")
				return
			}

		session.dataTask(with: request) { data, response, error in
			DispatchQueue.main.async {
				if error != nil {
					completion(nil, .unknown)
				} else if let data = data,
					let response = response as? HTTPURLResponse, response.isValidStatusCode {

					do {
						let trafficResponse = try JSONDecoder().decode(TrafficResponse.self, from: data)
						completion(trafficResponse, nil)
					} catch {
						completion(nil, .apiError(code: response.statusCode,
												  message: error.localizedDescription))
					}
				}
			}
		}.resume()
	}

	func downloadImage(_ url: String, completion: @escaping (Data?, Error?) -> Void) {
		session.dataTask(with: URL(string: url)!) { data, response, error in
			DispatchQueue.main.async {
				if let error = error {
					completion(nil, error)
				} else if let data = data, let response = response as? HTTPURLResponse,
					response.isValidStatusCode { completion(data, nil) }
			}
		}.resume()
	}
}
