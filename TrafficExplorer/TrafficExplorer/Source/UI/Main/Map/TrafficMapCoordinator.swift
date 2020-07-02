//
//  TrafficMapCoordinator.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

final class TrafficMapCoordinator: AnyMapCoordinator {
	private let navigationController: UINavigationController
	
	var api: AnyAPI { API(apiHost: Constants.baseURL,
						  session: URLSession.shared) }
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let mapController = TrafficMapViewController<TrafficMapPresenter<TrafficMapCoordinator>>()
		mapController.presenter = TrafficMapPresenter(coordinator: self)
		mapController.navigationItem.title = "Map".localized()
		
		navigationController.pushViewController(mapController, animated: true)
	}
	
	func dismiss() {
		navigationController.popToRootViewController(animated: true)
	}
	
	func showPin(camera: Any) {
		guard let camera = camera as? CameraResponse else { return }
		
		PinDetailsCoordinator(navigationController: navigationController,
							  camera: camera,
							  api: api).start()
	}
	
	func presentPopup(_ popup: Popup) {
		navigationController.presentPopup(popup)
	}
}
