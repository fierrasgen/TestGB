//
//  SecondViewController.swift
//  TestTuTu
//
//  Created by Alexander Novikov on 06.10.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var secondTableVIew: UITableView!
    
    var weathers = [Weather]()
    var weatherIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let city = "Moscow"
        WeatherManager.shared.loadWeatherData(city: "Moscow", completion: { [weak self] in
            DispatchQueue.main.async {
                print("Loaded weather from server")
                self?.weathers = WeatherManager.shared.loadWeatherDataFromRealm(city: city)
                self?.secondTableVIew.reloadData()
            }
        })
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (weathers.count > 0) {
            return 1
        }
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = secondTableVIew.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondTableViewCell
        
        let weatherInfo = weathers[weatherIndex]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let date = Date(timeIntervalSince1970: weatherInfo.date)
        let dateString = dateFormatter.string(from: date)
        
        cell.nameLabel.text = weatherInfo.weatherName
        cell.tempLabel.text = "\(weatherInfo.temp) degrees"
        cell.windDegreesLabel.text = "\(weatherInfo.windDegrees) wind"
        cell.windSpeedLabel.text = "\(weatherInfo.windSpeed) speed"
        cell.pressureLabel.text = "\(weatherInfo.pressure) pressure"
        cell.humidityLabel.text = "\(weatherInfo.humidity) humidity"
        cell.dateLabel.text = dateString
        
        return cell
        
    }
    
}
