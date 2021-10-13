//
//  CityModel.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import Foundation

struct CityModel: Codable {
    let id: Int?
    let name, region, country: String?
    let lat, lon: Double?
    let url: String?
}
