//
//  HomeCoordinator.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

final class HomeCoordinator: BaseNavigationController, AnyHomeCoordinator {
	func start() {
		let viewController = HomeViewController<HomePresenter>()
		viewController.presenter = HomePresenter(coordinator: self)
		viewController.navigationItem.title = "Home".localized()
		pushViewController(viewController, animated: false) // Home screen, no need to animate
	}
	
	func navigateToTrafficMap() {
		TrafficMapCoordinator(navigationController: self).start()
	}
}
