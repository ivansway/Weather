//
//  TableView.swift
//  Weather
//
//  Created by Ivan Myrza on 09/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import UIKit

class TableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // SUPERVIEW
    var superView: UIView
    private var mainVM: MainViewModel?
        
    internal var tableView: UITableView?
    
    init(superView: UIView) {
        self.superView = superView
        super.init()
        setup()
    }
    
    private func setup() {
        
        // TABLE VIEW SETUP
        tableViewSetup()
    }
    
    private func tableViewSetup() {
        
        self.tableView = UITableView()
        
        tableView?.register(WeatherPredicationCell.self, forCellReuseIdentifier: "WeatherPredicationCell")
        tableView?.delegate = self
        tableView?.dataSource = self
        
        superView.addSubview(tableView!)
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        tableView?.topAnchor.constraint(equalTo: superView.topAnchor, constant: 240).isActive = true
        tableView?.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        tableView?.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    
    // MARK: - Table view delegate / data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewModel.mainStorage?.daily?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherPredicationCell", for: indexPath) as! WeatherPredicationCell
        
        self.mainVM = MainViewModel()
        
        mainVM?.getWeatherUnit(indexPath: indexPath.row, weatherItem: "temperature", completion: { unit in
            cell.weatherTemperatureTitle(value: unit)
        })
        
        mainVM?.getWeatherUnit(indexPath: indexPath.row, weatherItem: "weekDay", completion: { unit in
            cell.dayTitle(text: unit)
        })
        
        mainVM?.getWeatherUnit(indexPath: indexPath.row, weatherItem: "weatherImage", completion: { unit in
            cell.weatherTypeImage(image: unit)
        })
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
