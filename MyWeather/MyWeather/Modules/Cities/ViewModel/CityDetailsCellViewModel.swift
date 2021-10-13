//
//  CityDetailsCellViewModel.swift
//  MyWeather
//
//  Created by mac on 10/13/21.
//

import Foundation

class CityDetailsCellViewModel  {
    var cityID: Int
    var cityName: String
    var currentTemp: Double
    var icon: String
    
    init(cityID: Int, cityName: String, currentTemp: Double, icon: String) {
        self.cityID = cityID
        self.cityName = cityName
        self.currentTemp = currentTemp
        self.icon = icon
    }
}
