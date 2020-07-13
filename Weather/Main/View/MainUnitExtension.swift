//
//  MainUnitExtension.swift
//  Weather
//
//  Created by Ivan Myrza on 10/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import UIKit

extension MainUnit {
    
    @objc internal func showWeather(sender: UIButton) {
        
        let mainVM = MainViewModel()
        self.mainVM = mainVM
        
        self.tableView = TableView(superView: superView)
                
        if sender.tag == 0 {
            
            
            self.mainVM?.getHeaderData(city: "saintPetersburg", item: "icon", completion: { icon in
                self.header?.weatherTypeTitle(text: icon, top: 100)
            })
            
            self.mainVM?.getHeaderData(city: "saintPetersburg", item: "icon", completion: { icon in
                self.header?.weatherTypeImage(type: icon, top: 100)
            })
            
            self.mainVM?.getHeaderData(city: "saintPetersburg", item: "temperature", completion: { icon in
                self.header?.weatherTemperatureTitle(text: icon, top: 100)
            })

            self.tableView?.tableView?.reloadData()
            
        } else if sender.tag == 1 {
            
            
            self.mainVM?.getHeaderData(city: "moscow", item: "icon", completion: { icon in
                self.header?.weatherTypeTitle(text: icon, top: 100)
            })
            
            self.mainVM?.getHeaderData(city: "moscow", item: "icon", completion: { icon in
                self.header?.weatherTypeImage(type: icon, top: 100)
            })
            
            self.mainVM?.getHeaderData(city: "moscow", item: "temperature", completion: { icon in
                self.header?.weatherTemperatureTitle(text: icon, top: 100)
            })
            
            self.tableView?.tableView?.reloadData()
              
        }
        
        // UNSERLINE CITY
        underline(buttonTag: sender.tag)
    }
}
