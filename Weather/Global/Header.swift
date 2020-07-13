//
//  Header.swift
//  Weather
//
//  Created by Ivan Myrza on 13/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import UIKit

class Header {
    
    private var superView: UIView
    
    init(superView: UIView) {
        self.superView = superView
    }
    
    private var weatherTypeTitle: UILabel? = UILabel()
    private var weatherTemperatureLabel: UILabel? = UILabel()
    private var weatherType: UIImageView? = UIImageView()
    
    internal func weatherTypeImage(type: String, top: CGFloat) {
                
        DispatchQueue.main.async {
            self.weatherType?.removeFromSuperview()
            
            Constraints.widthHeightLeadingTop(superView: self.superView,
                                              view: self.weatherType!,
                                              widthAnchor: 50,
                                              heightAnchor: 50,
                                              leadingAnchor: 20,
                                              topAnchor: top)
            
            switch type {
            case "sunny":
                guard let sunny = UIImage(named: "sunny") else {return}
                self.weatherType?.image = sunny
            case "clear-day":
                guard let sunny = UIImage(named: "sunny") else {return}
                self.weatherType?.image = sunny
                
            case "cloudy":
                guard let cloudy = UIImage(named: "cloudy") else {return}
                self.weatherType?.image = cloudy
                
            case "partly-cloudy-day":
                guard let cloudy = UIImage(named: "cloudy") else {return}
                self.weatherType?.image = cloudy
                
            case "rain":
                guard let rain = UIImage(named: "rain") else {return}
                self.weatherType?.image = rain
            default:
                guard let sunny = UIImage(named: "sunny") else {return}
                self.weatherType?.image = sunny
            }
        }
    }
    
    
    internal func weatherTypeTitle(text: String, top: CGFloat) {
        DispatchQueue.main.async {
            self.weatherTypeTitle?.text = text
            self.weatherTypeTitle?.font = UIFont(name: "Optima", size: 20)
            self.superView.addSubview(self.weatherTypeTitle!)
            self.weatherTypeTitle?.translatesAutoresizingMaskIntoConstraints = false
            self.weatherTypeTitle?.centerXAnchor.constraint(equalTo: self.superView.centerXAnchor).isActive = true
            self.weatherTypeTitle?.topAnchor.constraint(equalTo: self.superView.topAnchor, constant: top).isActive = true
        }
    }
    
    internal func weatherTemperatureTitle(text: String, top: CGFloat) {
        DispatchQueue.main.async {
            self.weatherTemperatureLabel?.text = text + " °C"
            self.weatherTemperatureLabel?.textAlignment = .right
            self.weatherTemperatureLabel?.font = UIFont(name: "Optima", size: 22)
            Constraints.widthHeightTrailingTop(superView: self.superView,
                                               view: self.weatherTemperatureLabel!,
                                               widthAnchor: 120,
                                               heightAnchor: 34,
                                               trailingAnchor: -20,
                                               topAnchor: top)
        }
    }
}
