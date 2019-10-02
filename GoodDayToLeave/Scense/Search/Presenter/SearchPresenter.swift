//
//  SearchPresenter.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/16.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

protocol BasePresenter: class {
    
}

class SearchPresenter: BasePresenter {

    var weatherService = WeatherService()
    var viewController = UIViewController()
    weak var view: SearchPresenterView?
    
    init(_ view: SearchPresenterView) {
        self.view = view
    }
    
    func getweatherCity(_ query: String) {
        weatherService.getweatherCity(query, view: viewController) { (model, err, message) in
            if err == nil {
                self.view?.getWeatherCity(model)
            } else {
                if let error = err {
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }
}

protocol SearchPresenterView: BaseView {
    func getWeatherCity(_ weatherModel:[WeatherModel])
}
