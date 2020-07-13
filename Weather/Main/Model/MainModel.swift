//
//  MainModel.swift
//  Weather
//
//  Created by Ivan Myrza on 09/07/2020.
//  Copyright © 2020 Ivan Myrza. All rights reserved.
//

import Foundation

struct MainStorage : Codable {
    let latitude : Double?
    let longitude : Double?
    let timezone : String?
    let currently : Currently?
    let hourly : Hourly?
    let daily : Daily?
    let flags : Flags?
}

struct Currently : Codable {
    let summary : String?
    let icon : String?
    let precipIntensity : Double?
    let precipProbability : Double?
    let precipType : String?
    let temperature : Double?
    let apparentTemperature : Double?
    let dewPoint : Double?
    let humidity : Double?
    let pressure : Double?
    let windSpeed : Double?
    let windGust : Double?
    let windBearing : Int?
    let cloudCover : Double?
}

struct Daily : Codable {
    let summary : String?
    let icon : String?
    let data : [Data]?
}

struct Data : Codable {
    let time: Double?
    let summary : String?
    let icon : String?
    let moonPhase : Double?
    let precipIntensity : Double?
    let precipIntensityMax : Double?
    let precipProbability : Double?
    let precipType : String?
    let temperatureHigh : Double?
    let temperatureLow : Double?
    let temperatureLowTime : Int?
    let apparentTemperatureHigh : Double?
    let apparentTemperatureLow : Double?
    let dewPoint : Double?
    let humidity : Double?
    let pressure : Double?
    let windSpeed : Double?
    let windGust : Double?
    let cloudCover : Double?
    let ozone : Double?
    let temperatureMin : Double?
    let temperatureMax : Double?
    let apparentTemperatureMin : Double?
    let apparentTemperatureMax : Double?

}

struct Flags : Codable {
    let sources : [String]?
    let meteoalarm_license : String?
    let nearest_station : Double?
    let units : String?

    enum CodingKeys: String, CodingKey {

        case sources = "sources"
        case meteoalarm_license = "meteoalarm-license"
        case nearest_station = "nearest-station"
        case units = "units"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sources = try values.decodeIfPresent([String].self, forKey: .sources)
        meteoalarm_license = try values.decodeIfPresent(String.self, forKey: .meteoalarm_license)
        nearest_station = try values.decodeIfPresent(Double.self, forKey: .nearest_station)
        units = try values.decodeIfPresent(String.self, forKey: .units)
    }

}

struct Hourly : Codable {
    let summary : String?
    let icon : String?
    let data : [Data]?

}




























































































//// MARK: - Welcome1
//struct MainStorage: Codable {
//    let latitude, longitude: Double?
//    let timezone: String?
//    let currently: Currently?
//    let hourly: Hourly?
//    let daily: Daily?
//    let flags: Flags?
//    let offset: Int?
//}
//
//// MARK: - Currently
//struct Currently: Codable {
//    let time: Int?
//    let precipIntensity, precipProbability: Double?
//
//    let temperature, apparentTemperature, dewPoint, humidity: Double?
//    let pressure, windSpeed, windGust: Double?
//    let windBearing: Int?
//    let cloudCover: Double?
//    let uvIndex, visibility: Int?
//    let ozone: Double?
//}
//
//
//
//// MARK: - Daily
//struct Daily: Codable {
//    let summary: String?
//
//    let data: [Datum]?
//}
//
//// MARK: - Datum
//struct Datum: Codable{
//    let time: Int?
//    let summary: String?
//    let sunriseTime, sunsetTime: Int?
//    let moonPhase, precipIntensity, precipIntensityMax: Double?
//    let precipIntensityMaxTime: Int?
//    let precipProbability: Double?
//    let temperatureHigh: Double?
//    let temperatureHighTime: Int?
//    let temperatureLow: Double?
//    let temperatureLowTime: Int?
//    let apparentTemperatureHigh: Double?
//    let apparentTemperatureHighTime: Int?
//    let apparentTemperatureLow: Double?
//    let apparentTemperatureLowTime: Int?
//    let dewPoint, humidity, pressure, windSpeed: Double?
//    let windGust: Double?
//    let windGustTime, windBearing: Int?
//    let cloudCover: Double?
//    let uvIndex, uvIndexTime: Int?
//    let visibility, ozone, temperatureMin: Double?
//    let temperatureMinTime: Int?
//    let temperatureMax: Double?
//    let temperatureMaxTime: Int?
//    let apparentTemperatureMin: Double?
//    let apparentTemperatureMinTime: Int?
//    let apparentTemperatureMax: Double?
//    let apparentTemperatureMaxTime: Int?
//}
//
//// MARK: - Flags
//struct Flags: Codable {
//    let sources: [String]?
//    let meteoalarmLicense: String?
//    let nearestStation: Double?
//    let units: String?
//}
//
//// MARK: - Hourly
//struct Hourly: Codable {
//    let summary: String?
//    let data: [Currently]?
//}













































//// MARK: - MainSorage
//struct MainStorage: Codable {
//    let latitude, longitude: Double?
//    let timezone: String?
//    let currently: Currently?
//    let hourly: Hourly?
//    let daily: Daily?
//    let flags: Flags?
//    let offset: Int?
//}
//
//// MARK: - Currently
//struct Currently: Codable {
//    let time: Int?
//    let summary: Summary?
//    let icon: Icon?
//    let precipIntensity, precipProbability: Double?
//    let precipType: Icon?
//    let temperature, apparentTemperature, dewPoint, humidity: Double?
//    let pressure, windSpeed, windGust: Double?
//    let windBearing: Int?
//    let cloudCover: Double?
//    let uvIndex, visibility: Int?
//    let ozone: Double?
//}
//
//enum Icon: String, Codable {
//    case clearDay = "clear-day"
//    case clearNight = "clear-night"
//    case cloudy = "cloudy"
//    case partlyCloudyDay = "partly-cloudy-day"
//    case partlyCloudyNight = "partly-cloudy-night"
//    case rain = "rain"
//}
//
//enum Summary: String, Codable {
//    case clear = "Clear"
//    case mostlyCloudy = "Mostly Cloudy"
//    case overcast = "Overcast"
//    case partlyCloudy = "Partly Cloudy"
//    case possibleDrizzle = "Possible Drizzle"
//    case possibleLightRain = "Possible Light Rain"
//}
//
//// MARK: - Daily
//struct Daily: Codable {
//    let summary: String?
//    let icon: Icon?
//    let data: [Datum]?
//}
//
//// MARK: - Datum
//struct Datum: Codable {
//    let time: Int?
//    let summary: String?
//    let icon: Icon?
//    let sunriseTime, sunsetTime: Int?
//    let moonPhase, precipIntensity, precipIntensityMax: Double?
//    let precipIntensityMaxTime: Int?
//    let precipProbability: Double?
//    let precipType: Icon?
//    let temperatureHigh: Double?
//    let temperatureHighTime: Int?
//    let temperatureLow: Double?
//    let temperatureLowTime: Int?
//    let apparentTemperatureHigh: Double?
//    let apparentTemperatureHighTime: Int?
//    let apparentTemperatureLow: Double?
//    let apparentTemperatureLowTime: Int?
//    let dewPoint, humidity, pressure, windSpeed: Double?
//    let windGust: Double?
//    let windGustTime, windBearing: Int?
//    let cloudCover: Double?
//    let uvIndex, uvIndexTime, visibility: Int?
//    let ozone, temperatureMin: Double?
//    let temperatureMinTime: Int?
//    let temperatureMax: Double?
//    let temperatureMaxTime: Int?
//    let apparentTemperatureMin: Double?
//    let apparentTemperatureMinTime: Int?
//    let apparentTemperatureMax: Double?
//    let apparentTemperatureMaxTime: Int?
//}
//
//// MARK: - Flags
//struct Flags: Codable {
//    let sources: [String]?
//    let meteoalarmLicense: String?
//    let nearestStation: Double?
//    let units: String
//
//    enum CodingKeys: String, CodingKey {
//        case sources
//        case meteoalarmLicense = "meteoalarm-license"
//        case nearestStation = "nearest-station"
//        case units
//    }
//}
//
//// MARK: - Hourly
//struct Hourly: Codable {
//    let summary: String?
//    let icon: Icon?
//    let data: [Currently]?
//}
