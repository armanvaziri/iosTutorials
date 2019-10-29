//
//  ViewController.swift
//  AVMapKitDemo
//
//  Created by Arman Vaziri on 10/28/19.
//  Copyright © 2019 ArmanVaziri. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cameraButton: UIButton!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.addSubview(cameraButton)
        cameraButton.layer.cornerRadius = cameraButton.frame.width / 2
        checkLocationServices()
        // Do any additional setup after loading the view.
    }
    
    // Required basic setup for the location manager
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // Zooms the map views to the users location
    func zoomViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters:2000, longitudinalMeters: 2000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // Step 1 in location authorization: checks if its been enabled or not, calls appropriate function
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // set up location  manager
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            //  show alert
            checkLocationAuthorization()
        }
    }
    
    // Step 2 in location authorization: checks the location authorization and acts accordingly
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Do stuff
            mapView.showsUserLocation = true
            zoomViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // Do stuff
            mapView.showsUserLocation = true
            zoomViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // show alert
            
            break
        case .restricted:
            // show alert
            break
        case .notDetermined:
            // request location
            locationManager.requestWhenInUseAuthorization()
            break
        @unknown default:
            showAlert(title: "Location error", message: "please enable location services")
            break
        }
    }
    
    // Function for showing alerts
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    /*------------- LocationManager Delegates -------------*/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }

}

