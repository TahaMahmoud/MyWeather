//
//  RequestBuilder.swift
//  MyWeather
//
//  Created by mac on 9/27/21.
//

import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible,RequestHandler {
    var mainURL: URL { get }
    
    var requestURL: URL { get }
    
    var path: String { get }
    
    var headers: HTTPHeaders { get }
    
    var parameters: Parameters? { get }
    
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
    
}

extension URLRequestBuilder {
    var mainURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var requestURL: URL {
        return mainURL.appendingPathComponent(path)
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(HTTPHeader(name: "Authorization", value: "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyOGU0Yjc1OGM4ODg3NDRlNTczNmQ2ZmI1MTkyOWYyMSIsInN1YiI6IjVjY2UxZjExMGUwYTI2MmZiYjA0Y2Q2OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.iSpO81qMhkUYyEMgW9wwKaUletRWjwJXLlcdWHSB6Mk"))
        
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
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.name)
        }
        return request
    }
    
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
