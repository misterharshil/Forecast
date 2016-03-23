//
//  Weather.swift
//  Forecast
//
//  Created by Harshil on 06/03/16.
//  Copyright © 2016 Harshil Parikh. All rights reserved.
//

import Foundation

struct Weather {
    let cityName: String
    let temp: Double
    let description: String
    let wind: Double
    let hum: Double
  // let min: Double
   // let icon: String
    
    init(cityName: String, temp: Double, description: String, wind: Double,hum: Double) {
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.wind = wind
        self.hum = hum
       // self.min = min
       // self.icon = icon
    }
}
