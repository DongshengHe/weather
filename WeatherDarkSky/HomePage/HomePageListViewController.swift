//
//  ViewController.swift
//  WeatherDarkSky
//
//  Created by Tony He on 2019/10/4.
//  Copyright © 2019 Tony He. All rights reserved.
//

import UIKit
import CoreLocation

class HomePageListViewController: UIViewController {

    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset.bottom = 34
        
        return tableView
    }()
    
    var weather:WeatherModel?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        addRightNavButton()
        getDarkSkyWeather(latitude: 37.8267, longitude: -122.4233)
    }

    private func buildUI(){
        title = "Weather"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherTableViewCell.classForCoder(), forCellReuseIdentifier: WeatherTableViewCell.description())
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func getDarkSkyWeather(latitude: CGFloat, longitude: CGFloat){
        let url = API().getDarkSkyWeatherUrl(latitude: latitude, longitude: longitude)
        
        NetworkTools.GET(url: url, params: nil, success: { (json) in
            let decoder = JSONDecoder()
            if let weatherData = try? decoder.decode(WeatherModel.self, from: json){
                self.weather = weatherData
            }
            
        }, failure: nil)
    }
    
    private func addRightNavButton(){
        let rightButton = UIBarButtonItem.init(title: "Get Local", style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc private func rightButtonTapped(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
        locationManager.startUpdatingLocation()
    }
}

extension HomePageListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather?.daily?.data?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let timeZone = weather?.timezone, let dailyData = weather?.daily?.data else {
            return UITableViewCell()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.description()) as? WeatherTableViewCell{
            cell.configureCell(with: dailyData[indexPath.row], timeZone: timeZone)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let summary = weather?.daily?.summary else {
            return
        }
        
        let weatherDetailsVC = WeatherDetailsViewController()
        weatherDetailsVC.summary = summary
        
        navigationController?.pushViewController(weatherDetailsVC, animated: true)

    }
}

extension HomePageListViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            self.getDarkSkyWeather(latitude: CGFloat(location.coordinate.latitude), longitude: CGFloat(location.coordinate.longitude))
            locationManager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        //do nothing
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //do nothing
    }
}
