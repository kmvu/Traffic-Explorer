//
//  Popup.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 17/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

// MARK: - Actions

public protocol AnyAction {
	var title: String { get }
	var callback: () -> Void { get }
}

public protocol AnyCancellableAction: AnyAction {}

public struct OKAction: AnyAction {
	public var title: String = "OK".localized()
	public var callback: () -> Void
	
	public init(_ callback: @escaping () -> Void = {}) {
		self.callback = callback
	}
}

public struct CancelAction: AnyCancellableAction {
	public var title: String = "Cancel".localized()
	public var callback: () -> Void
	
	public init(_ callback: @escaping () -> Void = {}) {
		self.callback = callback
	}
}

// MARK: - Popup

public protocol AnyPopupCoordinator {
	func presentPopup(_ popup: Popup)
}

extension AnyPopupCoordinator {
	public func presentError(_ anyError: Error?, _ message: String = "",
							 _ actions: [AnyAction] = [OKAction()]) {
		guard let error = anyError else { return }
		presentPopup(.error(error, message, actions))
	}
}

public struct Popup {
	public let title: String
	public let message: String
	public let actions: [AnyAction]
}

extension Popup {
	static func error(_ error: Error?, _ message: String,
					  _ actions: [AnyAction]) -> Popup {
		Popup(title: "Error".localized(),
			  message: message.isEmpty ? error?.localizedDescription ?? message : message,
			  actions: actions)
	}
}
