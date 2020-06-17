//
//  MapPresenter.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation
import Combine

public protocol AnyMapCoordinator {
	var api: AnyAPI! { get }
	
	func showPin()
	func getTrafficData()
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

public class TrafficMapPresenter: AnyMapPresenter {
	private let coordinator: AnyMapCoordinator
	private weak var view: AnyMapView?
	private var bag = Set<AnyCancellable>()
	
	public init(coordinator: AnyMapCoordinator) {
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
		
		
//
//		coordinator.api.trafficData()
//			.handleEvents(receiveOutput: { response in
//				debugPrint(response)
//			}, receiveCompletion: { [weak self] _ in
//				self?.view?.isLoading = false
//			})
//			.eraseToAnyPublisher()
	}
	
	public func displayPinPopup() {
		coordinator.showPin()
	}
}
