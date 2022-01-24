//
//  WeatherManager.swift
//  TestTuTu
//
//  Created by Alexander Novikov on 06.10.2021.
//

import Foundation
import Alamofire
import RealmSwift

class WeatherResponse: Decodable {
    let list: [Weather]
}

class WeatherManager {
    static let shared = WeatherManager()
    
    private init() {}
    
    let baseUrl = "http://api.openweathermap.org"
    let apiKey = "92cabe9523da26194b02974bfcd50b7e"
    
    enum Path: String {
        case forecasts = "/data/2.5/forecast"
    }
    
    @discardableResult func loadWeatherData(city: String, completion: @escaping () -> Void) -> Request {
        let path = Path.forecasts.rawValue
        
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        let url = baseUrl + path
        
        return Session.custom.request(url, parameters: parameters).responseData { [weak self] response in
            guard let data = response.value,
                  let weathers = self?.parseWeather(data, city)
            else {
                completion()
                return
            }
            self?.saveWeatherData(weathers)
            completion()
        }
    }
    
    func parseWeather(_ data: Data, _ city: String) -> [Weather] {
        //print(String(data: data, encoding: String.Encoding.utf8))
        guard let weather = try? JSONDecoder().decode(WeatherResponse.self, from: data)
        else {
            return []
        }
        weather.list.forEach { $0.city = city }
        return weather.list
    }
    
    func saveWeatherData(_ weathers: [Weather]) {
        guard let city = weathers.first?.city else { return }
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        //print(realm.configuration.fileURL)
        realm.beginWrite()
        let cityWeather = realm.objects(Weather.self).filter("city == %@", city)
        realm.delete(cityWeather)
        realm.add(weathers)
        try? realm.commitWrite()
    }
    
    func loadWeatherDataFromRealm(city: String) -> [Weather] {
        let realm = try! Realm()
        let weathers = realm.objects(Weather.self).filter("city == %@", city).sorted(byKeyPath: "date")
        return Array(weathers)
    }
}
