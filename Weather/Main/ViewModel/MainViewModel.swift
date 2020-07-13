//
//  MainViewModel.swift
//  Weather
//
//  Created by Ivan Myrza on 09/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import Foundation

class MainViewModel {
    
    private var network: MainNetworkManager?
    internal static var mainStorage: MainStorage?
    internal static var cache = NSCache<NSString, AnyObject>()
    internal static var currentCity = ""
    
    
    // RETURN HEADER DATA
    internal func getHeaderData(city: String, item: String, completion: @escaping (String) -> Void) {
        MainViewModel.currentCity = city
                 
        switch item {
        case "icon":
            if let icon = MainViewModel.cache.object(forKey: NSString(string: city + "Icon")) as? String {
                completion(icon)
            } else {
                self.chacheHeaderData(city: city, completion: { mainStorage in
                    completion(mainStorage.currently?.icon ?? "")
                    
                })
            }
        case "temperature":
            if let temperature = MainViewModel.cache.object(forKey: NSString(string: city + "Temperature")) as? String {
                completion(temperature)
            } else {
                self.chacheHeaderData(city: city, completion: { mainStorage in
                    completion(self.convertFahrenheitToCelsius(value: mainStorage.currently?.temperature ?? 0))
                   
                })
            }
        default:
            print("Return header default")
        }
    }
    
    
    // CACHING HEADER DATA
    internal func chacheHeaderData(city: String, completion: @escaping (MainStorage) -> Void) {
        
        self.getWheatherForCity(city: city) { mainStorage in
            
            completion(mainStorage)
            MainViewModel.mainStorage = mainStorage
            
            guard let current = mainStorage.currently else {return}
            
            let temperature = String(self.convertFahrenheitToCelsius(value: current.temperature ?? 0)) as AnyObject
            
            MainViewModel.cache.setObject(temperature, forKey: NSString(string: city + "Temperature"))
            MainViewModel.cache.setObject(current.icon as AnyObject, forKey: NSString(string: city + "Icon"))
        }
    }

    
    // RETURN TABLE VIEW DATA
    internal func getWeatherUnit(indexPath: Int, weatherItem: String, completion: @escaping (String) -> Void) {
                
        let city = MainViewModel.currentCity
        
        if weatherItem == "temperature" {
            
            if let weekTemperature = MainViewModel.cache.object(forKey: NSString(string:
                city + "WeekTemperature")) as? [String] {
                completion(weekTemperature[indexPath])
            } else {
                getWheatherForCity(city: city) { mainStorage in
                    
                    var arrayTemperature: [String] = []
                    guard let data = mainStorage.daily?.data else {return}
                    for item in data {arrayTemperature.append(String(self.convertFahrenheitToCelsius(value: item.apparentTemperatureLow ?? 0)))}
                    
                    MainViewModel.cache.setObject(arrayTemperature as AnyObject, forKey: NSString(string: city + "WeekTemperature"))
                    let cachedObject = MainViewModel.cache.object(forKey: NSString(string: city + "WeekTemperature")) as? [String] ?? []
                    completion(cachedObject[indexPath])
                }
            }
        }
        
        if weatherItem == "weekDay" {
            
            if let weekDay = MainViewModel.cache.object(forKey: NSString(string:
                city + "WeekDay")) as? [String] {
                completion(weekDay[indexPath])
            } else {
                getWheatherForCity(city: city) { mainStorage in
                    
                    var arrayDay: [String] = []
                    guard let data = mainStorage.daily?.data else {return}
                    for item in data {arrayDay.append(self.dateFormate(day: item.time ?? 0))}
                        
                
                    MainViewModel.cache.setObject(arrayDay as AnyObject, forKey: NSString(string: city + "WeekDay"))
                    let cachedObject = MainViewModel.cache.object(forKey: NSString(string: city + "WeekDay")) as? [String] ?? []
                    completion(cachedObject[indexPath])
                    
                }
            }
        }

        if weatherItem == "weatherImage" {
            
            if let weatherImage = MainViewModel.cache.object(forKey: NSString(string:
                city + "WeatherImage")) as? [String] {
                completion(weatherImage[indexPath])
            } else {
                getWheatherForCity(city: city) { mainStorage in
                    
                    var weatherImageArray: [String] = []
                    guard let data = mainStorage.daily?.data else {return}
                    for item in data {weatherImageArray.append(item.icon ?? "")}
                
                
                    MainViewModel.cache.setObject(weatherImageArray as AnyObject, forKey: NSString(string: city + "WeatherImage"))
                    let cachedObject = MainViewModel.cache.object(forKey: NSString(string: city + "WeatherImage")) as? [String] ?? []
                    completion(cachedObject[indexPath])
                }
            }
        }
    }
    
    // FETCHING DATA FOR CITY
    internal func getWheatherForCity(city: String, completion: @escaping (MainStorage) -> ()) {
        
        if city == "saintPetersburg" {
            fetchWeather(long: 59.950015, lat: 30.316599, completetion: { data in completion(data)
                MainViewModel.mainStorage = data
            })
        } else if city == "moscow" {
            fetchWeather(long: 55.753913, lat: 37.620836, completetion: { data in completion(data)
                MainViewModel.mainStorage = data
            })
        }
    }
    
    internal func fetchWeather(long: Double, lat: Double, completetion: @escaping (MainStorage) -> Void) {
        
        let network = MainNetworkManager()
        self.network = network
        
        self.network?.fetchWeather(long: long, lat: lat, completion: { data in
            completetion(data)
        })
    }
    
    internal func convertFahrenheitToCelsius(value: Double) -> String {
        return String(Int(value - 32) * 5 / 9)
    }
    
    internal func dateFormate(day: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EE, dd MMMM"
        let date = Date(timeIntervalSince1970: day)
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    @objc private func cacheClear() {
        MainViewModel.cache.removeAllObjects()
    }
}

extension MainViewModel {
    
    
    // GET WEATHER FOR MAP VIEW
    internal func getWeatherForCoordinate(lat: Double, long: Double, prefix: String, completion: @escaping (String) -> Void) {
        
        let objectKey = NSString(string: prefix + String(lat) + String(long))
        
        if prefix == "icon" {
            
            if let object = MainViewModel.cache.object(forKey: objectKey) as? String {
                completion(object)
            } else {
                fetchWeather(long: lat, lat: long) { mainStorage in
                    
                    MainViewModel.cache.setObject(mainStorage.currently?.icon as AnyObject, forKey: objectKey)
                    completion(MainViewModel.cache.object(forKey: objectKey) as? String ?? "")
                }
            }
        } else if prefix == "temperature" {
            
            if let object = MainViewModel.cache.object(forKey: objectKey) as? String {
                completion(object)
            } else {
                fetchWeather(long: lat, lat: long) { mainStorage in
                    
                    MainViewModel.cache.setObject(self.convertFahrenheitToCelsius(value: mainStorage.currently?.temperature ?? 0) as AnyObject, forKey: objectKey)
                    completion(MainViewModel.cache.object(forKey: objectKey) as? String ?? "")
                }
            }
        }
    }
}
