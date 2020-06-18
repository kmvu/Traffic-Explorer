//
//  HomeViewController.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 16/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

struct HomeMetrics {
	static let buttonSize: CGSize = .init(width: 100.0, height: 60.0)
}

class HomeViewController<Presenter: AnyHomePresenter>: UIViewController, AnyHomeView {
	
	var isNavigatingToMap: Bool = false
	var presenter: Presenter!
	
	private lazy var mapButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Map View".localized(), for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(goToMap), for: .touchUpInside)
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.title = "Home".localized()
		view.backgroundColor = .systemPink
		
		view.addSubview(mapButton)
		NSLayoutConstraint.activate([
			mapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			mapButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			mapButton.widthAnchor.constraint(equalToConstant: HomeMetrics.buttonSize.width),
			mapButton.heightAnchor.constraint(equalToConstant: HomeMetrics.buttonSize.height)
		])
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter.attach(view: self)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		presenter.detach()
	}
	
	@objc private func goToMap() {
		presenter.showMap()
	}
}

