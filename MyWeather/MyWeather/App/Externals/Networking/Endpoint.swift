//
//  Endpoint.swift
//  Football-League
//
//  Created by Ramzy on 14/07/2021.
//

import Foundation
import Alamofire

protocol Endpoint: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var requestURL: URL { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var method: HTTPMethod { get }
    var urlRequest: URLRequest { get }
}

extension Endpoint {
    var baseURL: String {
        return "http://api.weatherapi.com/v1/"
    }
    
    var requestURL: URL {
        return URL(string: baseURL + path)!
    }
    
    var defaultHeaders: HTTPHeaders {
        var headers = HTTPHeaders()
        // headers.add(name: "Content-Type", value: "application/json")
        //headers.add(name: "X-Auth-Token", value: "667ac0caf65341b1a023cd6f470d9c31")
        
        return headers
    }
    
    var defaultParams: Parameters {
        let param = Parameters()
        return param
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        defaultHeaders.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.name)
        }
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
}

