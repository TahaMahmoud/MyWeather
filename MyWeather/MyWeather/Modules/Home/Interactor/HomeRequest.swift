//
//  TrendingRequest.swift
//  Popcorn
//
//  Created by Taha on 16/04/2021.
//

import Foundation
import Alamofire

enum HomeRequest: Endpoint {
    case getWeatherWithCityName(cityName: String)
    case getWeatherWithLocation(location: String)

    var path: String {
        switch self {
        
        case .getWeatherWithCityName, .getWeatherWithLocation:
            return "forecast.json"
        }
    }
    
    var headers: HTTPHeaders {
        let headers = defaultHeaders
        return headers
    }
    
    var parameters: Parameters? {
        var param = defaultParams
        switch self {
        case .getWeatherWithCityName(let cityName):
            param = ["key": Constants.apiKey, "lang": "en", "q": cityName, "days": 5]
            
        case .getWeatherWithLocation(let location):
            param = ["key": Constants.apiKey, "lang": "en", "q": location, "days": 5]

        }
        
        return param
    }
    
    var method: HTTPMethod {
        switch self {

        case .getWeatherWithCityName:
            return .get
        case .getWeatherWithLocation:
            return .get

        }
    }
}
