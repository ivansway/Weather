//
//  Map.swift
//  Weather
//
//  Created by Ivan Myrza on 10/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

class Map: NSObject, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    private var superView: UIView
    
    private var header: Header?
    
    // DELEGATE
    weak var mapViewDelegate: GMSMapViewDelegate?
    var locationManager = CLLocationManager()
    let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    private var mainVM: MainViewModel?
    private var network: MainNetworkManager?
    
    var mapView: GMSMapView?
    
    init(superView: UIView) {
        self.superView = superView
        super.init()
        setup()
        
    }
    
    private func setup() {
        mapViewSetup()
        
        
    }
    
    private func mapViewSetup() {
            
        let camera = GMSCameraPosition.camera(withLatitude: -33.898698, longitude: 151.220688, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: superView.bounds, camera: camera)
        superView.addSubview(mapView!)
        
        mapView?.settings.myLocationButton = true
        mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView?.isMyLocationEnabled = true
        
        // DELEGATE
        self.locationManager.delegate = self
        self.mapView?.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            self.mapView?.isMyLocationEnabled = true
            self.mapView?.settings.myLocationButton = true
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.requestLocation()
        
        self.mapView?.isMyLocationEnabled = true
        self.mapView?.settings.myLocationButton = true
    }
    
    // DID UPDATE LOCATION
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //guard let locations = locations.first else { return }
        
        
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: 1)
        
        mapView = GMSMapView.map(withFrame: superView.bounds, camera: camera)
        
        
        
        let position = CLLocationCoordinate2D(latitude: 59.90934499999999, longitude: 30.324946)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = self.mapView
        
        
        
        reverseGeocode(coordinate: position)
    }
    
    // ERROR
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // CONVERTING COORDINATE TO ADRESS
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        
        GMSGeocoder().reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else { return }
            
            // PASS ADRESS
            print(lines.joined(separator: "\n"))
            
        }
        
    }
    
    // CHANGING MAP POINT
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.reverseGeocode(coordinate: position.target)
    }
    
//    private func fetchWetherForPosition(long: Double, lat: Double) {
//
//
//        mainVM.fetchWeather(long: long, lat: lat, completetion: { mainStorage in
//            print(mainStorage.currently?.icon as Any)
//        })
//    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        showWeatherForCoordinate(lat: coordinate.latitude, long: coordinate.longitude)
    }
    
    private func showWeatherForCoordinate(lat: Double, long: Double) {
        
        // VM INIT
        let mainVM = MainViewModel()
        self.mainVM = mainVM
        
        // BACK
        let back = UIView()
        back.backgroundColor = .white
        Constraints.widthHeightLeadingTop(superView: self.superView, view: back, widthAnchor: 200, heightAnchor: 80, leadingAnchor: self.superView.frame.width / 2 - 100, topAnchor: 50)
        
        // HEADER INIT
        self.header = Header(superView: back)
        
        self.mainVM?.getWeatherForCoordinate(lat: lat, long: long, prefix: "icon", completion: { value in
            self.header?.weatherTypeImage(type: value, top: 30)
            self.header?.weatherTypeTitle(text: value, top: 10)
        })
        
        self.mainVM?.getWeatherForCoordinate(lat: lat, long: long, prefix: "temperature", completion: { value in
            self.header?.weatherTemperatureTitle(text: value, top: 40)
        })
        
        
        
        
    }
}
