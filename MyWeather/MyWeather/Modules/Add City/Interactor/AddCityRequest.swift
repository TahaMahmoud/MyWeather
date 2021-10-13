//
//  AddCityRequest.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import Foundation
import Alamofire

enum AddCityRequest: Endpoint {
    case fetchCities(cityName: String)

    var headers: HTTPHeaders {
        let headers = defaultHeaders
        return headers
    }

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
            param = ["key": Constants.apiKey, "q": cityName]
    
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
