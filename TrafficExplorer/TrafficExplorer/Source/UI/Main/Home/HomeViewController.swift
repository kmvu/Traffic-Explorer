//
//  HomeViewController.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

class HomeViewController<Presenter: AnyHomePresenter>: UIViewController, AnyHomeView {
	var isNavigatingToMap: Bool = false
	var presenter: Presenter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.title = "Home".localized()
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

