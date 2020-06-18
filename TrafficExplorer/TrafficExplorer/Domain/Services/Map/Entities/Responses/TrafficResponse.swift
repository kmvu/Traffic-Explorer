//
//  TrafficResponse.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

public struct TrafficResponseItem: Decodable {
	public let timestamp: String
	public let cameras: [CameraResponse]
}

public struct APIInfo: Decodable {
	public let status: String
}

public struct TrafficResponse: Decodable {
	public let items: [TrafficResponseItem]
	public let api_info: APIInfo
	
	public init(items: [TrafficResponseItem], info: APIInfo) {
		self.items = items
		self.api_info = info
	}
}
