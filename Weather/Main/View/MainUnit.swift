//
//  MainUnit.swift
//  Weather
//
//  Created by Ivan Myrza on 09/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import UIKit

class MainUnit {
    
    internal var mainVM: MainViewModel?
    internal var weatherCell: WeatherPredicationCell?
    internal var header: Header?
   
    internal var superView: UIView
    internal var navController: UINavigationController
    
    internal var tableView: TableView?
            
        
    // UNDERLINE CITY VIEW
    var line: UIView? = UIView()
    
    // INIT
    init(superView: UIView, navController: UINavigationController) {
        self.superView = superView
        self.navController = navController
        setup()
    }
    
    // SETUP
    private func setup() {
        
        // HEADER INIT
        self.header = Header(superView: self.superView)

        header?.weatherTypeImage(type: "sunny", top: 100)
        
        header?.weatherTypeTitle(text: "sunny", top: 100)
        
        header?.weatherTemperatureTitle(text: "10", top: 100)
        
        // MOSCOW BUTTON
        moscowButton()
        
        // SAINT-PETERSBURG BUTTON
        saintPetersburgButton()
        
        // WEATHER MAP
        weatherMapButton()
        
        let mainVM = MainViewModel()
        self.mainVM = mainVM
        
        self.mainVM?.getHeaderData(city: "saintPetersburg", item: "temperature", completion: { icon in
            self.header?.weatherTemperatureTitle(text: icon, top: 100)
        })
    }
    
    private func weatherMapButton() {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Optipma", size: 22)
        button.titleLabel?.textAlignment = .right
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor
        button.layer.cornerRadius = 7
        button.setTitleColor(UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
        button.setTitle("Weather map", for: .normal)
        button.addTarget(self, action: #selector(pushMapVC), for: .touchUpInside)
        Constraints.widthHeightTrailingTop(superView: superView, view: button, widthAnchor: 130, heightAnchor: 30, trailingAnchor: -16, topAnchor: 40)
    }
    
    private func moscowButton() {
        
        let button = UIButton()
        button.setTitle("Moscow", for: .normal)
        button.titleLabel?.font = UIFont(name: "Optima", size: 18)
        button.titleLabel?.textAlignment = .right
        button.tag = 1
        button.setTitleColor(UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(showWeather), for: .touchUpInside)
        Constraints.widthHeightTrailingTop(superView: superView,
                                           view: button,
                                           widthAnchor: 80,
                                           heightAnchor: 30,
                                           trailingAnchor: -20,
                                           topAnchor: 190)
    }
    
    private func saintPetersburgButton() {
        
        let button = UIButton()
        button.setTitle("Saint-Petersburg", for: .normal)
        button.titleLabel?.font = UIFont(name: "Optima", size: 18)
        button.titleLabel?.textAlignment = .left
        button.tag = 0
        button.setTitleColor(UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(showWeather), for: .touchUpInside)
        Constraints.widthHeightLeadingTop(superView: superView,
                                          view: button,
                                          widthAnchor: 140,
                                          heightAnchor: 30,
                                          leadingAnchor: 20,
                                          topAnchor: 190)
        
       
    }
    
    internal func underline(buttonTag: Int) {
        
        self.line?.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.6)
        self.line?.layer.borderWidth = 1
        
        if buttonTag == 0 {
            for item in self.line!.constraints { item.isActive = false }
            self.line?.removeFromSuperview()
            Constraints.widthHeightLeadingTop(superView: superView,
                                              view: self.line!,
                                              widthAnchor: 150,
                                              heightAnchor: 1,
                                              leadingAnchor: 15,
                                              topAnchor: 218)
        } else {
            for item in self.line!.constraints { item.isActive = false }
            self.line?.removeFromSuperview()
            Constraints.widthHeightTrailingTop(superView: superView,
                                               view: self.line!,
                                               widthAnchor: 90,
                                               heightAnchor: 1,
                                               trailingAnchor: -15,
                                               topAnchor: 218)
        }
    }
}


