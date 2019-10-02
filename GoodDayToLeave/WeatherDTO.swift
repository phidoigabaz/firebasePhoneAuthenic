//
//  WeatherDTO.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/13.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherDTO: NSObject {
    var name: String
    var id: String
    var lat: Double
    var lon: Double
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    var weatherCity: [WeatherCityDTO] = []
    var clouds: Double
    
    init(_ json: JSON) {
        name = json["name"].stringValue
        id = json["id"].stringValue
        lat = json["coord"]["lat"].doubleValue
        lon = json["coord"]["lon"].doubleValue
        temp = json["main"]["temp"].doubleValue
        temp_min = json["main"]["temp_min"].doubleValue
        temp_max = json["main"]["temp_max"].doubleValue
        for (_ ,subJson) in json["weather"] {
            weatherCity.append(WeatherCityDTO(subJson))
        }
        clouds = json["clouds"]["all"].doubleValue
    }
}
