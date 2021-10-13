//
//  CityModel.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import Foundation

class CityModel: Codable {
    let id: Int?
    let name, region, country: String?
    let lat, lon: Double?
    let url: String?
}

class City {
    var cityID: Int
    var cityName: String = ""
    var isDefaultCity: Bool = false
    
    init(cityID: Int, cityName: String, isDefaultCity: Bool) {
        self.cityID = cityID
        self.cityName = cityName
        self.isDefaultCity = isDefaultCity
    }

}

