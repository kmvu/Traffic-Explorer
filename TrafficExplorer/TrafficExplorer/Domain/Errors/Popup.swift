//
//  Popup.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 17/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

public protocol AnyAction {
	var title: String { get }
	var callback: () -> Void { get }
}

public struct OKAction: AnyAction {
	public let title: String = "OK"
	public let callback: () -> Void
	
	public init(_ callback: @escaping () -> Void = { }) {
		self.callback = callback
	}
}

public protocol AnyCancellableAction: AnyAction { }

public protocol AnyPopupCoordinator {
	func presentPopup(_ popup: Popup)
}

extension AnyPopupCoordinator {
	public func presentError(_ error: Error) {
		switch error {
			default:
				presentPopup(.error(error, actions:[OKAction()]))
		}
	}
}

public struct Popup {
	public let title: String
	public let message: String
	public let actions: [AnyAction]
}

extension Popup {
	static func error(_ anyError: Error, actions: [AnyAction]) -> Popup {
		Popup(title: "Error".localized(),
			  message: anyError.localizedDescription,
			  actions: actions)
	}
}
