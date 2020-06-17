//
//  TrafficMapViewController.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 17/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

final class TrafficMapViewController<Presenter: AnyMapPresenter>: UIViewController, AnyMapView {
	var presenter: Presenter!
	
	var isLoading: Bool = false
	var mapModel: TrafficResponse?
	
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
}
