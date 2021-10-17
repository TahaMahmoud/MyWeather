//
//  AddCityViewController+Location.swift
//  MyWeather
//
//  Created by mac on 10/17/21.
//

import Foundation
import CoreLocation
import RxSwift

extension AddCityViewController: CLLocationManagerDelegate {
    
    func startLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if currentLocation == nil {
            currentLocation = locations.last
            locationManager.stopMonitoringSignificantLocationChanges()
            let locationValue:CLLocationCoordinate2D = manager.location!.coordinate

            locationManager.stopUpdatingLocation()
            
            let latitude = "\(locationValue.latitude)"
            let longitude = "\(locationValue.longitude)"
                
            viewModel.fetchCities(cityName: "", latitude: latitude, longitude: longitude)

        }
        
    }
}
    

