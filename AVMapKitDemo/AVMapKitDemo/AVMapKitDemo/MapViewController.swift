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
    @IBOutlet weak var cameraButton: UIButton!
    
    var locationManager: CLLocationManager!
    var userLocation: CLLocation!
    var imageToPin: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.layer.cornerRadius = cameraButton.frame.height/2
        mapView.delegate = self
        checkLocationAuthorization()
        locationManager = CLLocationManager()
        // test to place pin
//        let campanile = CLLocationCoordinate2D(latitude: 37.872087, longitude: -122.257752)
        let currLocation = locationManager.location?.coordinate
        placePins(place: currLocation!, image: UIImage(named: "lighthouse"))
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "camera", sender: sender)
    }
    
    
    // checks whether the user has authorized location services
    func checkLocationAuthorization() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // set map location on user's current location
            locationManager = CLLocationManager()
            userLocation = locationManager.location!
            centerMapOnLocation(location: userLocation!)
            mapView.showsUserLocation = true
        } else {
            locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
        if image != nil {
            imageToPin = image
        }
        annotation.coordinate = place
        annotation.title = "pictureTaken"
        annotation.subtitle = ""
        mapView.addAnnotation(annotation)
//        mapView.reloadInputViews()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    // refreshes user location, tracks movement
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("updated latest location")
        
        guard let latestLocation = locations.first else {return}
        
        if userLocation == nil {
            centerMapOnLocation(location: latestLocation)
        }
        userLocation = latestLocation
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    
    // adds images to the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
//        if let title = annotation.title, title == "pictureTaken" {
//            let imageToPin = resizeImage(image: UIImage(named: "lighthouse")!, size: CGSize(width: 60, height: 60))
//            annotationView?.image = imageToPin
//        }
        if let title = annotation.title, title == "pictureTaken" {
            let annotationImage = resizeImage(image: imageToPin!, size: CGSize(width: 60, height: 60))
            annotationView?.image = annotationImage
        }
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    
    // resizes images to be added to map
    func resizeImage(image: UIImage, size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image {(context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
}
