//
//  Enum.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/11.
//  Copyright © 2019 dattt. All rights reserved.
//

import Foundation
import UIKit
import EmptyStateKit

enum MenuType {
    case hushList
    case calendarCheck
    case set
    case setting
    
    func displayString() -> String {
        switch self {
        case .hushList:
            return "Hush List"
        case .calendarCheck:
            return "Calendar Check"
        case .set:
            return "Set"
        case .setting:
            return "Setting"
        }
    }
}

enum APICode: Int {
    case success = 200
    case failed = 404
    case invalidAPIKey = 401
}

//weather: Api
enum AppWeather {
    case getWeatherCity(_ query: String)
    case getWeatherWeek(_ query: String)
    case getWeatherLocation(_ lat: String, _ lon: String)
    case getWeatherDailyCity(_ query: String)
}

enum WeatherIcon {
    case sun
    case cloudy
    case rain
    case weatherIce
    
    func displayImage() -> UIImage! {
        switch self {
        case .sun:
            return UIImage(named: "sun")
        case .cloudy:
            return UIImage(named: "cloud")
        case .rain:
            return UIImage(named: "rain")
        case .weatherIce:
            return UIImage(named: "weatherIce")
        }
    }
}

//tripiso: Api
enum Tripiso {
    case tour(_ query: String)
}


enum TableState: CustomState {
    case noLogin
    
    var image: UIImage? {
        switch self {
        case .noLogin:
            return UIImage(named: "profile")
        }
    }
    
    var title: String? {
        switch self {
        case .noLogin:
            return "Not logged In"
        }
    }
    
    var description: String? {
        switch self {
        case .noLogin:
            return "Please enter the correct phone number!"
        }
    }
    
    var titleButton: String? {
        switch self {
        case .noLogin:
            return "Cancel"
        }
    }
}
