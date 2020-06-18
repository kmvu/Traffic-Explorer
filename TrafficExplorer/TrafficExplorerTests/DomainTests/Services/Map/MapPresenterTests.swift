//
//  MapPresenterTests.swift
//  TrafficExplorerTests
//
//  Created by Khang Vu on 17/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import XCTest
@testable import TrafficExplorer

class MapPresenterTests: XCTestCase {
	var coordinator: MockMapCoordinator!
	var mapPresenter: TrafficMapPresenter<MockMapCoordinator>!
	
	override func setUp() {
		super.setUp()
		
		coordinator = MockMapCoordinator()
		mapPresenter = TrafficMapPresenter(coordinator: coordinator)
	}
	
	func testTrafficDataHasBeenFetched() {
		let view = MockMapView()
		XCTAssertFalse(view.isLoading)
		
		mapPresenter.attach(view: view)
		
		XCTAssertTrue(view.isLoading)
	}
	
	func testPinHasShown() {
		let view = MockMapView()
		XCTAssertFalse(coordinator.didShowPinIcon)
		
		mapPresenter.attach(view: view)
		mapPresenter.showDetails(camera: "")
		
		XCTAssertTrue(coordinator.didShowPinIcon)
	}
	
	override func tearDown() {
		super.tearDown()
		mapPresenter.detach()
	}
}
