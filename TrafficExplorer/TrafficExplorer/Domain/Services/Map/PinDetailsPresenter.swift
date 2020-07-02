//
//  PinDetailsPresenter.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 18/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

protocol AnyDetailsView: AnyObject {
	var isLoading: Bool { get set }
	var model: Any? { get set }
}

public protocol AnyDetailsCoordinator: AnyAPICoodinator, AnyPopupCoordinator {}

protocol AnyDetailsPresenter {
	func attach<View: AnyDetailsView>(view: View)
	func detach()
	
	func retrieveData(_ url: String)
}

class PinDetailsPresenter<Coordinator: AnyDetailsCoordinator>: AnyDetailsPresenter {
	private let coordinator: Coordinator
	private weak var view: AnyDetailsView?
	
	private let imageURL: String
	
	init(coordinator: Coordinator, imageURL: String) {
		self.coordinator = coordinator
		self.imageURL = imageURL
	}
	
	func attach<View: AnyDetailsView>(view: View) {
		self.view = view
		retrieveData(imageURL)
	}
	
	func detach() {
		self.view = nil
	}
	
	func retrieveData(_ url: String) {
		view?.isLoading = true
		
		coordinator.api.downloadImage(url) { [weak self] data, error in
			guard let self = self else { return }
			
			guard error == nil else {
				self.coordinator.presentError(error)
				return
			}
			self.view?.isLoading = false
			self.view?.model = data
		}
	}
}
