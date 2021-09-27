//
//  ResponseDecoder.swift
//  MyWeather
//
//  Created by mac on 9/27/21.
//

import Foundation

protocol ResponseDecoder: Codable {
    init(data: Data) throws
}

extension ResponseDecoder  {
    init(data: Data) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}
