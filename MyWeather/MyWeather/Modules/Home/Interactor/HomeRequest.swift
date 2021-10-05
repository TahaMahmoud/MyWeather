//
//  TrendingRequest.swift
//  Popcorn
//
//  Created by Ramzy on 16/04/2021.
//

import Foundation
import Alamofire

enum HomeRequest: URLRequestBuilder {
    case getWeather

    var path: String {
        switch self {
        
        case .getWeather:
            return "forecast.json"
        }
    }
    
    var parameters: Parameters? {
        var param = defaultParams
        switch self {
        case .getWeather:
            param = ["key": Constants.apiKey, "lang": "en", "q": "Cairo", "days": 5]
        }

        return param
    }
    
    var method: HTTPMethod {
        switch self {

        case .getWeather:
            return .get
            
        }
    }
}
