//
//  MapPresenter.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

public protocol AnyMapCoordinator {
	func showPin()
}

public protocol AnyMapView: AnyObject {
	var isLoading: Bool { get set }
	var mapModel: TrafficResponse { get set }
}

public protocol AnyMapPresenter {
	func attach<View: AnyMapView>(view: View)
	func detach()
	
	func displayPinPopup()
}

public class TrafficMapPresenter: AnyMapPresenter {
	private let coordinator: AnyMapCoordinator
	private weak var view: AnyMapView?
	
	public init(coordinator: AnyMapCoordinator) {
		self.coordinator = coordinator
	}
	
	public func attach<View: AnyMapView>(view: View) {
		self.view = view
		
		fetchTrafficData()
	}
	
	public func detach() {
		
	}
	
	private func fetchTrafficData() {
		view?.isLoading = true
		
		coordinator.getTrafficData()
	}
	
	public func displayPinPopup() {
		coordinator.showPin()
	}
}
