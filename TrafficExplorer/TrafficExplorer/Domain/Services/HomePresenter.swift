//
//  HomePresenter.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

public protocol AnyHomeCoordinator {
	func navigateToTrafficMap()
}

public protocol AnyHomePresenter {
	func showMap()
}

public class HomePresenter: AnyHomePresenter {
	private let coordinator: AnyHomeCoordinator
	
	public init(coordinator: AnyHomeCoordinator) {
		self.coordinator = coordinator
	}
	
	public func showMap() {
		coordinator.navigateToTrafficMap()
	}
}
