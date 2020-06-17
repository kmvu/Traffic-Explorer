//
//  TrafficMapCoordinator.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

final class TrafficMapCoordinator: AnyMapCoordinator {
	var api: AnyAPI!
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let mapController = TrafficMapViewController<TrafficMapPresenter>()
		mapController.presenter = TrafficMapPresenter(coordinator: self)
		mapController.navigationItem.title = "Map".localized()
		navigationController.pushViewController(mapController, animated: true)
	}
	
	func showPin() {
		
	}
	
	func getTrafficData() {
		
	}
}
