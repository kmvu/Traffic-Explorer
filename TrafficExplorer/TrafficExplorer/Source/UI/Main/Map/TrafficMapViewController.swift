//
//  TrafficMapViewController.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 17/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit
import MapKit

final class TrafficMapViewController<Presenter: AnyMapPresenter>: UIViewController, AnyMapView {
	var presenter: Presenter!
	
	var isLoading: Bool = false
	var mapModel: TrafficResponse? {
		didSet {
			self.updateMapView(with: mapModel)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter.attach(view: self)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		presenter.detach()
	}
	
	// MARK: - Map
	
	private func updateMapView(with response: TrafficResponse?) {
		guard let response = response else { return }
		print(response)
	}
}
