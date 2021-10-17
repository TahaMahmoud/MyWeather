//
//  HomeViewController+Location.swift
//  MyWeather
//
//  Created by mac on 10/17/21.
//

import Foundation
import CoreLocation
import RxSwift

extension HomeViewController: CLLocationManagerDelegate {
    
    func startLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue: CLLocationCoordinate2D = manager.location?.coordinate {
            latitude = "\(locValue.latitude)"
            longitude = "\(locValue.longitude)"
            
            viewModel.getWeather(latitude: latitude, longitude: longitude)
        }
    }

    func bindRequestLocation() {
        viewModel.requestLocation.subscribe { [weak self] (response) in
            if response.element ?? true {
                self?.startLocation()
            }
        }.disposed(by: disposeBag)
    }
    
}
