 //
//  APIMoya.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/13.
//  Copyright © 2019 dattt. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
 
 var shouldTimeout: (() -> (Bool))?
 
 struct Network {
    static let provider = MoyaProvider<AppWeather>(endpointClosure: failureEndpointClosure)
    
    static func request(
        target: AppWeather,
        success successCallback: @escaping (JSON) -> Void,
        error errorCallback: @escaping (_ statusCode: Int) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try JSON(response.mapJSON())
                    successCallback(json)
                }
                catch let error {
                    errorCallback(error as! Int)
                }
            case let .failure(error):
                failureCallback(error)
            }
        }
    }
 }
 
 struct NetWorkTripiso {
    static let provider = MoyaProvider<Tripiso>(endpointClosure: failureEndpointClosureTripiso)
    
    static func request(
        target: Tripiso,
        success successCallback: @escaping (JSON) -> Void,
        error errorCallback: @escaping (_ statusCode: Int) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try JSON(response.mapJSON())
                    successCallback(json)
                }
                catch let error {
                    errorCallback(error as! Int)
                }
            case let .failure(error):
                failureCallback(error)
            }
        }
    }
 }
 
 let apiProviderMoya = MoyaProvider<AppWeather>(endpointClosure: failureEndpointClosure)

 let failureEndpointClosure = { (target: AppWeather) -> Endpoint in
    let sampleResponseClosure = { () -> (EndpointSampleResponse) in
        if (shouldTimeout != nil) {
            return .networkError(NSError())
        } else {
            return .networkResponse(APICode.success.rawValue, target.sampleData)
        }
    }
    return Endpoint(url: "\(URL(target: target))",
        sampleResponseClosure: sampleResponseClosure,
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers)
 }
 
 let apiProviderMoyaTripiso = MoyaProvider<Tripiso>(endpointClosure: failureEndpointClosureTripiso)
 
 let failureEndpointClosureTripiso = { (target: Tripiso) -> Endpoint in
    let sampleResponseClosure = { () -> (EndpointSampleResponse) in
        if (shouldTimeout != nil) {
            return .networkError(NSError())
        } else {
            return .networkResponse(APICode.success.rawValue, target.sampleData)
        }
    }
    return Endpoint(url: "\(URL(target: target))",
        sampleResponseClosure: sampleResponseClosure,
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers)
 }

 
 extension AppWeather: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }
    
    var path: String {
        switch self {
        case .getWeatherCity,
             .getWeatherWeek,
             .getWeatherLocation:
            return "weather"
        case .getWeatherDailyCity:
            return "forecast/daily"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeatherCity,
             .getWeatherWeek,
             .getWeatherLocation,
             .getWeatherDailyCity:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getWeatherCity:
            return "city".utf8Encoded
        case .getWeatherWeek:
            return "week".utf8Encoded
        case .getWeatherLocation:
            return "day".utf8Encoded
        case .getWeatherDailyCity:
            return "daily".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .getWeatherCity(let query):
            return .requestParameters(parameters: ["q" : query, "appid" : Constants.APIKEY_WEATHER], encoding: URLEncoding.queryString)
        case .getWeatherWeek(let query):
            return .requestParameters(parameters: ["q" : query, "appid" : Constants.APIKEY_WEATHER], encoding: URLEncoding.queryString)
        case .getWeatherLocation(let lat,let lon):
            return .requestParameters(parameters: ["lat" : lat, "lon" : lon, "appid" : Constants.APIKEY_WEATHER], encoding: URLEncoding.queryString)
        case .getWeatherDailyCity(let query):
            return .requestParameters(parameters: ["q" : query, "appid" : Constants.APIKEY_WEATHER], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
 }
 
 extension Tripiso: TargetType {
    var baseURL: URL {
        return URL(string: "https://tripiso.com/api/20190906/")!
    }
    
    var path: String {
        switch self {
        case .tour:
            return "tour.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .tour:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .tour:
            return "tour".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .tour(let query):
            return .requestParameters(parameters: ["annotate=trigram": query], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "X-Triposo-Accoun": Constants.ACCOUNT_ID,
                "X-Triposo-Token": Constants.API_TOKEN]
    }
 }
 // MARK: - Helpers
 private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
 }
 
