//
//  MainNetworkManager.swift
//  Weather
//
//  Created by Ivan Myrza on 09/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import Foundation

class MainNetworkManager {
        
    private var apiKey = "baca03956c7f74dc1b7ce0fdb637759a"
    
    internal func fetchWeather(long: Double, lat: Double, completion: @escaping (MainStorage) -> Void) {
        
        guard let url = URL(string: "https://api.darksky.net/forecast/\(apiKey)/\(long),\(lat)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(MainStorage.self, from: data)
                    completion(json)
                } catch let error {
                    print(error.localizedDescription)
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }.resume()
    }
}
