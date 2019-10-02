//
//  WeatherSerice.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/13.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherService: NSObject {
    func getWeatherLocation(_ lat: Double,_ lon: Double,completion: @escaping(([WeatherModel],NSError?) -> Void)) {
        apiProviderMoya.request(.getWeatherLocation(String(lat), String(lon))) { (result) in
            switch result {
            case .success(_):
                do {
                    let response = try result.get()
                    let value = try response.mapString()
                    if let data = value.data(using: .utf8) {
                        if let json = try? JSON(data: data) {
                            var models: [WeatherModel] = []
                            let dto = WeatherDTO(json)
                            let model = WeatherModel(dto)
                            models.append(model)
                            completion(models,nil)
                        }
                    }
                } catch {
                    
                }
            case .failure(let error):
                completion([WeatherModel](), error as NSError)
                print(error.localizedDescription)
            }
        }
    }
    
    func getweatherCity(_ query: String,view: UIViewController,completion: @escaping(([WeatherModel],NSError?,String?) -> Void)) {
        
        Network.request(target: .getWeatherDailyCity(query), success: { (json) in
            if json["cod"].intValue == APICode.success.rawValue {
                var models: [WeatherModel] = []
                let dto = WeatherDTO(json)
                let model = WeatherModel(dto)
                models.append(model)
                completion(models,nil,json["message"].rawString())
            } else {
                view.showAlertCancel(title: nil, message: json["message"].rawString())
            }
        }, error: { (err) in
            completion([WeatherModel](),err as! Error as NSError,nil)
        }) { (MoyaError) in
            print(MoyaError)
        }
    }
}
