//
//  HomeCoordinator.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

final class HomeCoordinator: BaseNavigationController, AnyHomeCoordinator {	
	func navigateToTrafficMap() {
		TrafficMapCoordinator(navigationController: self).start()
	}
}
