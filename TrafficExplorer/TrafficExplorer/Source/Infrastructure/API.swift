//
//  API.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

public class API: AnyAPI {
   private let apiHost: String
   private let session: URLSession
   
   public init(apiHost: String, session: URLSession) {
      self.apiHost = apiHost
      self.session = session
   }
   
   public func getURLComponents() -> URLComponents {
      URLComponents(url: URL(string: apiHost)!, resolvingAgainstBaseURL: false)!
   }
   
   public func execute(request: URLRequest) {
	return self.execute(request: request) { result in
		switch result {
			case let .failure(error):
				.error(error)
			case let .success(data):
				.success(data)
		}
	}
   }
   
   private func handleResponse(_ response: HTTPURLResponse, data: Data,
							   callback: @escaping (Swift.Result<Data, Error>) -> Void) {
      guard response.isValidContentType else {
         return callback(.failure(RepositoryError.invalidContentType(file: file, line: line)))
      }
      guard response.isValidStatusCode else {
         return callback(.failure(RepositoryError.invalidStatusCode(file: file, line: line)))
      }
      return callback(.success(data))
   }
   
   private func execute(request: URLRequest, callback: @escaping (Result<Data, Error>) -> Void) {
      guard request.url != nil else {
         return callback(.failure(RepositoryError.invalidRequestURL(file: file, line: line)))
      }
      session.dataTask(with: request) { [unowned self] (data, response, error) in
         if let error = error {
            guard request.cachePolicy == .useProtocolCachePolicy,
               let cachedResponse = self.session.configuration.urlCache?.cachedResponse(for: request),
               let cachedHttpResponse = cachedResponse.response as? HTTPURLResponse,
               !cachedResponse.data.isEmpty else {
               return callback(.failure((error as NSError).asKnownError(file: file, line: line)))
            }
            return self.handleResponse(
               cachedHttpResponse,
               data: cachedResponse.data,
               callback: callback)
         }
         guard let data = data, let httpResponse = response as? HTTPURLResponse else {
            return callback(.failure(RepositoryError.invalidResponse(file: file, line: line)))
         }
         return self.handleResponse(
            httpResponse,
            data: data,
            callback: callback)
      }.resume()
   }
}

private extension HTTPURLResponse {
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
