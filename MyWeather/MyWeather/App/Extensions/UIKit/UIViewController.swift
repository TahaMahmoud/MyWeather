//
//  UIViewController.swift
//  MyWeather
//
//  Created by mac on 10/4/21.
//

import UIKit

extension UIViewController {
    
    internal func getColor(type: WeatherType) -> UIColor {
        switch type {
        case .sunny:
            return UIColor(named: "SunnyColor") ?? UIColor.systemOrange
        case .rainy:
            return UIColor(named: "RainyColor") ?? UIColor.systemBlue
        case .fuggy:
            return UIColor(named: "FuggyColor") ?? UIColor.systemGray
        default:
            return UIColor(named: "SunnyColor") ?? UIColor.systemOrange
        }
    }

}
