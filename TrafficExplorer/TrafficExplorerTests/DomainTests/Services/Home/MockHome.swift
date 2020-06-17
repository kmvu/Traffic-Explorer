//
//  MockHome.swift
//  TrafficExplorerTests
//
//  Created by Khang Vu on 17/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

@testable import TrafficExplorer

class MockHomeView: AnyHomeView {
	var isNavigatingToMap: Bool = false
	var presenter: HomePresenter<MockHomeCoordinator>?
}

class MockHomeCoordinator: AnyHomeCoordinator {
	var didNavigateToMapScreen = false
	
	func navigateToTrafficMap() {
		didNavigateToMapScreen = true
	}
}
