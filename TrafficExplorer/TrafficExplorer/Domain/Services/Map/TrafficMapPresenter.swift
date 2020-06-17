//
//  MapPresenter.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

public protocol AnyMapCoordinator: AnyPopupCoordinator {
	var api: AnyAPI { get }
	
	func showPin()
}

public protocol AnyMapView: AnyObject {
	var isLoading: Bool { get set }
	var mapModel: TrafficResponse? { get set }
}

public protocol AnyMapPresenter {
	func attach<View: AnyMapView>(view: View)
	func detach()
	
	func displayPinPopup()
}

public class TrafficMapPresenter<Coordinator: AnyMapCoordinator>: AnyMapPresenter {
	private let coordinator: Coordinator
	private weak var view: AnyMapView?
	
	public init(coordinator: Coordinator) {
		self.coordinator = coordinator
	}
	
	public func attach<View: AnyMapView>(view: View) {
		self.view = view
		
		fetchTrafficData()
	}
	
	public func detach() {
		self.view = nil
	}
	
	private func fetchTrafficData() {
		view?.isLoading = true
		
		coordinator.api.trafficData { [weak self] response, error in
			guard let self = self else { return }
			
			if let error = error {
				self.coordinator.presentError(error)
			} else {
				self.view?.isLoading = false
				self.view?.mapModel = response
			}
		}
	}
	
	public func displayPinPopup() {
		coordinator.showPin()
	}
}
