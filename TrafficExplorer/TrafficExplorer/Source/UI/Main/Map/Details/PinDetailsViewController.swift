//
//  PinDetailsViewController.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 18/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit

final class PinDetailsViewController<Presenter: AnyDetailsPresenter>: UIViewController, AnyDetailsView {
	var presenter: Presenter!
	var isLoading: Bool = false {
		didSet {
			isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
		}
	}
	
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView()
		view.hidesWhenStopped = true
		view.style = .large
		view.center = self.view.center
		return view
	}()
	
	var model: Any? {
		didSet {
			guard
				let data = model as? Data,
				let image = UIImage(data: data)
			else { return }
			imageView.image = image
		}
	}
	
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		[imageView, activityIndicator].forEach(view.addSubview)
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
}
