//
//  CameraResponse.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

public struct CameraLocation: Decodable {
	public let latitude: Double
	public let longitude: Double
}

public struct ImageMetaData: Decodable {
	public let height: Int
	public let width: Int
	public let md5: String
}

public struct CameraResponse: Decodable {
	public let timestamp: String
	public let image: String
	public let location: CameraLocation
	public let camera_id: String
	public let image_metadata: ImageMetaData
}
