//
//  OnBoardingModel.swift
//  MyWeather
//
//  Created by mac on 9/27/21.
//

import Foundation

enum WeatherType {
    case sunny
    case rainy
    case fuggy
}

struct OnBoardingModel {
    
    let onBoardingNo: Int
    let title: String
    let onBoardingImage: String
    let onBoardingType: WeatherType

    init(onBoardingNo: Int, title: String, onBoardingImage: String, type: WeatherType) {
        self.onBoardingNo = onBoardingNo
        self.title = title
        self.onBoardingImage = onBoardingImage
        self.onBoardingType = type
    }
    
}
