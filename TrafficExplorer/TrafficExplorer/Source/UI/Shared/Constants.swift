//
//  Constants.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

struct Constants {
	static var baseURL = URL(string: "https://api.data.gov.sg")!
	
    enum Key: String {
        case accessToken = "oauth_token"
    }
        
    enum HTTPMethod: String {
        case GET, POST
    }
}
