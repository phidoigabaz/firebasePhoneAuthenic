//
//  WeatherCityModel.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/16.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class WeatherCityModel: NSObject {
    var id: Int
    var main: String
    var desc: String
    var icon: String
    
    init(_ dto: WeatherCityDTO) {
        id = dto.id
        main = dto.main
        desc = dto.desc
        icon = dto.icon
    }
}
