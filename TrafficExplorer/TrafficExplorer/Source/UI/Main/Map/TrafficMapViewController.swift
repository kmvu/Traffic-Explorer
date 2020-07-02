//
//  TrafficMapViewController.swift
//  TrafficExplorer
//
//  Created by Khang Vu on 17/6/20.
//  Copyright © 2020 com.khang.vu. All rights reserved.
//

import UIKit
import MapKit

struct MapMetrics {
	static let oneMinute: Double = 60.0
}

final class TrafficMapViewController<Presenter: AnyMapPresenter>: UIViewController,
AnyMapView, MKMapViewDelegate {
	var presenter: Presenter!
	
	var isLoading: Bool = false {
		didSet {
			isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
		}
	}
	
	var mapModel: TrafficResponse? {
		didSet {
			guard let response = mapModel, response.items.isEmpty == false else { return }
			
			// Supposed we only have today, at the time of this API response and we want
			// to just show all of the cameras' locations for this particular time due to time constraint purposes.
			//
			// If the app requires to display the cameras over list of dates (not just one day like in this case)
			// , then we can have a scrollable list of dates to select from and display accordingly
			// or just have previous/next buttons to navigate through each date from the map itself.
			let cameras = response.items.first!.cameras
			self.updateMapView(with: cameras)
		}
	}
	
	private lazy var mapView: MKMapView = {
		let mapView = MKMapView()
		mapView.translatesAutoresizingMaskIntoConstraints = false
		mapView.delegate = self
		return mapView
	}()

	private lazy var activityIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView()
		view.hidesWhenStopped = true
		view.style = .large
		view.center = self.view.center
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		[mapView, activityIndicator].forEach(view.addSubview)
		
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		// Fetching latets data every one minute, as per recommended by the Service themselves
		presenter.attach(view: self) // Load API the first time, then another minute, and so on...
		Timer.scheduledTimer(timeInterval: MapMetrics.oneMinute,
							 target: self,
							 selector: #selector(fetchLatestData),
							 userInfo: nil, repeats: true)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		presenter.detach()
	}
	
	@objc func fetchLatestData() {
		presenter.fetchTrafficData()
	}
	
	// MARK: - Map
	
	private func updateMapView(with cameras: [CameraResponse]) {
		let singapore = CLLocation(latitude: 1.290270, longitude: 103.851959)
		self.mapView.center(to: singapore)
		
		// Add annotation(pin)s to mapView
		cameras.forEach { camera in mapView.addAnnotation(camera) }
	}
	
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		guard let camera = view.annotation as? CameraResponse else {
			self.presenter.presentError(error: nil, message: "There are no image for this location")
			return
		}
		mapView.deselectAnnotation(camera, animated: true)
		presenter.showDetails(camera: camera)
	}
}

extension CameraResponse: MKAnnotation {
	public var coordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(latitude: location.latitude,
							   longitude: location.longitude)
	}
}

private extension MKMapView {
	func center(to location: CLLocation,
				regionRadius: CLLocationDistance = 5000) { // default 5 km
		let region = MKCoordinateRegion(center: location.coordinate,
										latitudinalMeters: regionRadius,
										longitudinalMeters: regionRadius)
		setRegion(region, animated: true)
	}
}
