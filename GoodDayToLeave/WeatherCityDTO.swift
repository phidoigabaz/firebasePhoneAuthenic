//
//  WeatherCityDTO.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/16.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherCityDTO: NSObject {
    var id: Int
    var main: String
    var desc: String
    var icon: String
    
    init(_ json: JSON) {
        id = json["id"].intValue
        main = json["main"].stringValue
        desc = json["description"].stringValue
        icon = json["icon"].stringValue
    }
}
