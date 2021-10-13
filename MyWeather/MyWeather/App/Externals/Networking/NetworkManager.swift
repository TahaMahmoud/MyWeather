//
//  NetworkManager.swift
//  Football-League
//
//  Created by Ramzy on 14/07/2021.
//


import Foundation
import Alamofire

protocol NetworkProtocol: AnyObject {
    func callRequest<T>(_ object: T.Type, endpoint: Endpoint, onComplete: @escaping ((Result<T, Error>) -> Void)) where T: Codable
}

class AlamofireManager: NetworkProtocol {
    func callRequest<T>(_ object: T.Type, endpoint: Endpoint, onComplete: @escaping ((Result<T, Error>) -> Void)) where T : Decodable, T : Encodable {
        AF.request(endpoint).responseJSON { (response) in
            do {
                guard let statusCode = response.response?.statusCode else {return}
                switch statusCode {
                case 200:
                    let model = try JSONDecoder().decode(T.self, from: response.data!)
                    onComplete(.success(model))
                case 403:
                    onComplete(.failure(NetworkError.forbidden))
                default:
                    onComplete(.failure(NetworkError.somethingWentWrong))
                }
            } catch {
                onComplete(.failure(NetworkError.somethingWentWrong))
            }
        }
    }
}

