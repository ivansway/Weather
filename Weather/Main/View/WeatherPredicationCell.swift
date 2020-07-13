//
//  DayPredicationCell.swift
//  Weather
//
//  Created by Ivan Myrza on 09/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import UIKit

class WeatherPredicationCell: UITableViewCell {
    
    private var dayTitleLabel: UILabel? = UILabel()
    private var weatherTypeImage: UIImageView? = UIImageView()
    private var weatherTemperatureLabel: UILabel? = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func weatherTemperatureTitle(value: String) {
        DispatchQueue.main.async {
            self.weatherTemperatureLabel?.text = value + " °C"
            self.weatherTemperatureLabel?.font = UIFont(name: "Optima", size: 20)
            Constraints.widthHeightLeadingTop(superView: self,
                                              view: self.weatherTemperatureLabel!,
                                              widthAnchor: 80,
                                              heightAnchor: 34,
                                              leadingAnchor: 76,
                                              topAnchor: 25)
        }
    }
    
    internal func weatherTypeImage(image: String) {
        
        DispatchQueue.main.async {
                        
            self.weatherTypeImage!.removeFromSuperview()
            
            Constraints.widthHeightLeadingTop(superView: self,
                                              view: self.weatherTypeImage!,
                                              widthAnchor: 50,
                                              heightAnchor: 50,
                                              leadingAnchor: 16,
                                              topAnchor: 15)
            
            switch image {
            case "rain":
                self.weatherTypeImage!.image = UIImage(named: "rain")
            case "cloudy":
                self.weatherTypeImage?.image = UIImage(named: "cloudy")
            case "clear-day":
                self.weatherTypeImage?.image = UIImage(named: "sunny")
            case "partly-cloudy-day":
                self.weatherTypeImage?.image = UIImage(named: "sunny")
            case "clear-night":
                self.weatherTypeImage?.image = UIImage(named: "clear-night")
            case "sunny":
                self.weatherTypeImage?.image = UIImage(named: "sunny")
            default:
                self.weatherTypeImage?.image = UIImage(named: "sunny")
            }
        }
    }
    
    
    internal func dayTitle(text: String) {
        
        DispatchQueue.main.async {
            self.dayTitleLabel?.removeFromSuperview()
            self.dayTitleLabel?.text = text
            self.dayTitleLabel?.font = UIFont(name: "Optima", size: 16)
            Constraints.trailingTopStretchableWidthHeight(superView: self,
                                                          view: self.dayTitleLabel!,
                                                          trailing: -16,
                                                          top: 25,
                                                          width: 10,
                                                          height: 34)
        }
    }
}
