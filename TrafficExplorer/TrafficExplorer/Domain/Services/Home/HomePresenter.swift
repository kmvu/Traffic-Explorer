//
//  HomePresenter.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

public protocol AnyHomeCoordinator {
	func navigateToTrafficMap()
}

public protocol AnyHomeView {
	var isNavigatingToMap: Bool { get set }
}

public protocol AnyHomePresenter {
	func attach<View: AnyHomeView>(view: View)
	func detach()
	
	func showMap()
}

public class HomePresenter<Coordinator: AnyHomeCoordinator>: AnyHomePresenter {
	private var view: AnyHomeView?
	private let coordinator: Coordinator
	
	public init(coordinator: Coordinator) {
		self.coordinator = coordinator
	}
	
	public func attach<View>(view: View) where View : AnyHomeView {
		self.view = view
	}
	
	public func detach() {
		self.view = nil
	}
	
	public func showMap() {
		view?.isNavigatingToMap = true
		coordinator.navigateToTrafficMap()
	}
}
