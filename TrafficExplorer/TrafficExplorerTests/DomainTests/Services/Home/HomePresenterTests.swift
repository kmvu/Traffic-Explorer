//
//  HomePresenterTests.swift
//  TrafficExplorerTests
//
//  Created by Khang Vu on 17/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import XCTest
@testable import TrafficExplorer

class HomePresenterTests: XCTestCase {
	var coordinator: MockHomeCoordinator!
	
	var homePresenter: HomePresenter<MockHomeCoordinator>!
	
	override func setUp() {
		super.setUp()
		
		coordinator = MockHomeCoordinator()
		homePresenter = HomePresenter(coordinator: coordinator)
	}
	
	func testNavigateToMapScreen() {
		let view = MockHomeView()
		XCTAssertFalse(view.isNavigatingToMap)
		
		homePresenter.attach(view: view)
		homePresenter.showMap()
		
		XCTAssertTrue(view.isNavigatingToMap)
	}
	
	override func tearDown() {
		super.tearDown()
		homePresenter.detach()
	}
}
