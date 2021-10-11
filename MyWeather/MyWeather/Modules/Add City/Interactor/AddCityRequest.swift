//
//  AddCityRequest.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import Foundation
import Alamofire

enum AddCityRequest: URLRequestBuilder {
    case fetchCities(cityName: String)

    var path: String {
        switch self {
        
        case .fetchCities:
            return "search.json"
        }
    }
    
    var parameters: Parameters? {
        var param = defaultParams
        switch self {
        case .fetchCities(let cityName):
            param = ["key": Constants.apiKey, "q": "Giza"]
    
        }
        
        return param
    }
    
    var method: HTTPMethod {
        switch self {

        case .fetchCities:
            return .get

        }
    }
}
