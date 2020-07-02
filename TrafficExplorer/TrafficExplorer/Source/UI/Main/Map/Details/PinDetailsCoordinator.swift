//
//  PinDetailsCoordinator.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 18/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

final class PinDetailsCoordinator: AnyDetailsCoordinator {
	private let navigationController: UINavigationController
	private let camera: CameraResponse
	
	var api: AnyAPI
	
	init(navigationController: UINavigationController,
		 camera: CameraResponse, api: AnyAPI) {
		self.navigationController = navigationController
		self.camera = camera
		self.api = api
	}
	
	func start() {
		let pinDetailsController = PinDetailsViewController<PinDetailsPresenter<PinDetailsCoordinator>>()
		pinDetailsController.presenter = PinDetailsPresenter(coordinator: self,
															 imageURL: camera.image)
		pinDetailsController.navigationItem.title = "Image #%@".localizedFormat(camera.camera_id)		
		navigationController.pushViewController(pinDetailsController, animated: true)
	}
	
	func presentPopup(_ popup: Popup) {
		navigationController.presentPopup(popup)
	}
}
