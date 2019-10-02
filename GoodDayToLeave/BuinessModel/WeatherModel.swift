//
//  WeatherModel.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/13.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherModel: NSObject {
    var name: String
    var id: String
    var lat: Double
    var lon: Double
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    var weatherCity: [WeatherCityModel] = []
    var clouds: Double
    
    init(_ dto: WeatherDTO) {
        name = dto.name
        id = dto.id
        lat = dto.lat
        lon = dto.lon
        temp = dto.temp
        temp_min = dto.temp_min
        temp_max = dto.temp_max
        for dto in dto.weatherCity {
            weatherCity.append(WeatherCityModel(dto))
        }
        clouds = dto.clouds
    }
}
