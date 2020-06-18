//
//  MapPresenter.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

public protocol AnyAPICoodinator {
	var api: AnyAPI { get }
}

public protocol AnyMapCoordinator: AnyAPICoodinator, AnyPopupCoordinator {
	func showPin(camera: Any)
}

public protocol AnyMapView: AnyObject {
	var isLoading: Bool { get set }
	var mapModel: TrafficResponse? { get set }
}

public protocol AnyMapPresenter {
	func attach<View: AnyMapView>(view: View)
	func detach()
	
	func showDetails(camera: Any)
	func presentError(error: Error?, message: String)
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
			self.view?.isLoading = false
			
			if let error = error {
				self.coordinator.presentError(error)
			} else {
				self.view?.mapModel = response
			}
		}
	}
	
	public func showDetails(camera: Any) {
		coordinator.showPin(camera: camera)
	}
	
	public func presentError(error: Error? = nil, message: String = "") {
		self.coordinator.presentError(error, message)
	}
}
