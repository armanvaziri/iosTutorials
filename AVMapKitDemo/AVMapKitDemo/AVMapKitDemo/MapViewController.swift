//
//  MapViewController.swift
//  AVMapKitDemo
//
//  Created by Arman Vaziri on 10/31/19.
//  Copyright © 2019 ArmanVaziri. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationAuthorization()
        
        // set initial location on user's current location
        locationManager = CLLocationManager()
        centerMapOnLocation(location: locationManager.location!)
        
        // test to place pin
        let campanile = CLLocationCoordinate2D(latitude: 37.872087, longitude: -122.257752)
        placePins(place: campanile, image: nil)
    }
    
    // checks whether the user has authorized location services
    func checkLocationAuthorization() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
          mapView.showsUserLocation = true
        } else {
          locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // centers the map on the specified location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: 1500, longitudinalMeters: 1500)
      mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // places pins on the specified coordinates
    func placePins(place: CLLocationCoordinate2D, image: UIImage?) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = place
        annotation.title = ""
        annotation.subtitle = ""
        mapView.addAnnotation(annotation)
    }

}
