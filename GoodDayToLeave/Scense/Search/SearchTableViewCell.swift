//
//  SearchTableViewCell.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/16.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var desCityLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    @IBOutlet weak var thumbCityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.borderView()
        dropShadow()
    }
    
    func bindingWithModel(_ model: WeatherModel) {
        nameCityLabel.text = model.name
        desCityLabel.text = model.weatherCity.first?.desc
        tempCityLabel.text = "\((Double(model.temp/10) - 273.15) * 9/5)° C"
        if let iconWeather = model.weatherCity.first?.icon {
            if let url = URL(string: "\(Constants.kURLIconWeather)\(iconWeather)@2x.png") {
                thumbCityImageView.kf.setImage(with: url)
            }
        }
        
        if let url = URL(string: "\(Constants.kURLIconWeather)10d.png") {
            thumbCityImageView.kf.setImage(with: url)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
