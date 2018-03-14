//
//  MapViewController.swift
//  parkidle
//
//  Created by Simone Staffa on 14/03/18.
//  Copyright © 2018 Parkidle. All rights reserved.
//

import UIKit
import Mapbox
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var mapView:MGLMapView!
    var latitude:CLLocationDegrees!
    var longitude:CLLocationDegrees!
    var mLocation:CLLocationCoordinate2D!
    var mMarker:MGLPointAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: "mapbox://styles/mapbox/streets-v10")
        mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06), zoomLevel: 9, animated: false)
        mapView.showsUserLocation = true;
        view.addSubview(mapView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        // Wait for the map to load before initiating the first camera movement.
        
        // Create a camera that rotates around the same center point, rotating 180°.
        // `fromDistance:` is meters above mean sea level that an eye would have to be in order to see what the map view is showing.
        let camera = MGLMapCamera(lookingAtCenter: mapView.centerCoordinate, fromDistance: 4500, pitch: 15, heading: 180)
        
        // Animate the camera movement over 5 seconds.
        mapView.setCamera(camera, withDuration: 10, animationTimingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10;
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        // Mauna Kea, Hawaii
        mLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // Optionally set a starting point.
        mapView.setCenter(mLocation, zoomLevel: 15, direction: 0, animated: false)
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        if(mMarker == nil){
            print("Marker is Nil")
            // Add a point annotation
            mMarker = MGLPointAnnotation()
            mMarker!.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            mMarker!.title = "IO"
            mMarker!.subtitle = "The biggest park in New York City!"
            mapView.addAnnotation(mMarker!)
        }else{
            MGLAnnotationView.animate(withDuration: 0.5, animations: {
                // Here Core Animation calls MapBox using an implicit animation.
                self.mMarker!.coordinate = CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
            })
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
