//
//  DayCellViewModel.swift
//  MyWeather
//
//  Created by mac on 10/5/21.
//

import Foundation

class DayCellViewModel  {
    var dayName: String
    var temp: Double
    var icon: String
    
    init(dayName: String, temp: Double, icon: String) {
        self.dayName = dayName
        self.temp = temp
        self.icon = icon
    }
}
