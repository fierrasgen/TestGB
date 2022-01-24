//
//  Weather.swift
//  TestTuTu
//
//  Created by Alexander Novikov on 06.10.2021.
//

import Foundation
import RealmSwift

class Weather: Object, Decodable {
    @objc dynamic var date = 0.0
    @objc dynamic var temp = 0.0
    @objc dynamic var pressure = 0.0
    @objc dynamic var humidity = 0
    @objc dynamic var weatherName = ""
    @objc dynamic var weatherIcon = ""
    @objc dynamic var windSpeed = 0.0
    @objc dynamic var windDegrees = 0.0
    @objc dynamic var city = ""
    
    override init() {
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
        case wind
    }
    
    enum MainKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
    }
    
    enum WeatherKeys: String, CodingKey {
        case main
        case icon
    }
    
    enum WindKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try values.decode(Double.self, forKey: .date)
        let main  = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        self.temp = try main.decode(Double.self, forKey: .temp)
        self.pressure = try main.decode(Double.self, forKey: .pressure)
        self.humidity = try main.decode(Int.self, forKey: .humidity)
        var weather = try values.nestedUnkeyedContainer(forKey: .weather)
        let firstWeather = try weather.nestedContainer(keyedBy: WeatherKeys.self)
        self.weatherName = try firstWeather.decode(String.self, forKey: .main)
        self.weatherIcon = try firstWeather.decode(String.self, forKey: .icon)
        let wind = try values.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        self.windSpeed = try wind.decode(Double.self, forKey: .speed)
        self.windDegrees = try wind.decode(Double.self, forKey: .degree)
    }
}
