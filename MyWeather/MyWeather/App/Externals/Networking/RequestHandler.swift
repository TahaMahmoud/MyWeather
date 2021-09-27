//
//  RequestHandler.swift
//  MyWeather
//
//  Created by mac on 9/27/21.
//

import Foundation
import Alamofire

typealias CallResponse<T> = ((ServerResponse<T>) -> Void)?

protocol RequestHandler: HandleRequestResponse { }

enum ServerResponse<T> {
    case success(T), failure(Error)
}

struct UploadData {
    var data: Data
    var fileName, mimeType, name: String
}


extension RequestHandler {
    private func uploadToServerWith<T: ResponseDecoder>(_ decoder: T.Type, data: UploadData, request: URLRequestConvertible, parameters: Parameters?, progress: ((Progress) -> Void)?, completion: CallResponse<T>) {
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data.data, withName: data.name,fileName: data.fileName, mimeType: data.mimeType)
            guard let parameters = parameters else { return }
            for (key,value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, with: request).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).responseData { (response) in
            switch response.result {
            case .success(_):
                self.handleResponse(response, completion: completion)
            case .failure(let error):
                completion?(ServerResponse<T>.failure(error))
            }
        }
    }
    
    
    func cancelRequest() {
        
        
    }
}

extension RequestHandler where Self: URLRequestBuilder {
    func send<T: ResponseDecoder>(_ decoder: T.Type, data: UploadData? = nil, progress: ((Progress) -> Void)? = nil, completion: CallResponse<T>) {
        if let data = data {
            uploadToServerWith(decoder, data: data, request: self, parameters: self.parameters, progress: progress, completion: completion)
        } else {
            AF.request(self).validate().responseData { (response) in
                self.handleResponse(response, completion: completion)
            }
        }
    }
}
