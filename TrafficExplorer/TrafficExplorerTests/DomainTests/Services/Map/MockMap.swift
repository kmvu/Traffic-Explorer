//
//  MockMap.swift
//  TrafficExplorerTests
//
//  Created by Khang Vu on 17/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation
@testable import TrafficExplorer

class MockAPI: AnyAPI {
	var apiHost: URL = URL(string: "some.api.com")!
	var session: URLSession = .init(configuration: .default)
	var spyURLComponentsCount: Int = 0
	
	func getURLComponents() -> URLComponents {
		spyURLComponentsCount += 1
		return URLComponents(url: apiHost, resolvingAgainstBaseURL: false)!
	}
}

class MockMapView: AnyMapView {
	var isLoading: Bool = false
	var mapModel: TrafficResponse?
}

class MockMapCoordinator: AnyMapCoordinator {
	var api: AnyAPI = MockAPI()
	
	var didShowPinIcon: Bool = false
	var didPopupPresent: Bool = false
	
	func presentPopup(_ popup: Popup) {
		didPopupPresent = true
	}
	
	func showPin() {
		didShowPinIcon = true
	}
}
