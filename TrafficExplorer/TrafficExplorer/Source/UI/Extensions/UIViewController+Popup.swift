//
//  UIViewController+Popup.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 17/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

extension UIViewController: AnyPopupCoordinator {
	public func presentPopup(_ popup: Popup) {
		present(popup.controller, animated: true, completion: nil)
	}
}

private extension Popup {
	var controller: UIAlertController {
		let alertController = UIAlertController(title: title,
												message: message,
												preferredStyle: .alert)
		actions.forEach { action in
			alertController.addAction(
				UIAlertAction(title: action.title,
							  style: action is AnyCancellableAction ? .cancel : .default,
							  handler: { _ in action.callback() })
			)
		}
		return alertController
	}
}
