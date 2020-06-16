//
//  BaseNavigationController.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
	override var preferredStatusBarStyle: UIStatusBarStyle {
		topViewController?.preferredStatusBarStyle ?? .default
	}
}
