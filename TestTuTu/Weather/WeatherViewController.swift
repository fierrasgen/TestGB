//
//  WeatherViewController.swift
//  TestTuTu
//
//  Created by Alexander Novikov on 06.10.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var weather = [Weather]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let city = "Moscow"
        WeatherManager.shared.loadWeatherData(city: "Moscow", completion: { [weak self] in
            DispatchQueue.main.async {
                print("Loaded weather from server")
                self?.weather = WeatherManager.shared.loadWeatherDataFromRealm(city: city)
                self?.tableView.reloadData()
            }
        })
    }
}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (weather.count > 0) {
            return 5
        }
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherViewCell
        
        let weatherInfo = weather[indexPath.row]
        cell.nameLabel.text = weatherInfo.weatherName
        cell.tempLabel.text = "\(weatherInfo.temp) degrees"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        vc.weatherIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
