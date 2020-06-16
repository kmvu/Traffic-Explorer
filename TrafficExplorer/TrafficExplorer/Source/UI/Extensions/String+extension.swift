//
//  String+extension.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import Foundation

extension String {
	func localized() -> String {
		return NSLocalizedString(self, comment: self)
	}
	
	func localizedFormat(_ args: CVarArg...) -> String {
		return String(format: localized(), arguments: args)
	}
}
