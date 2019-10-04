//
//  WeatherDetailsViewController.swift
//  WeatherDarkSky
//
//  Created by Tony He on 2019/10/4.
//  Copyright © 2019 Tony He. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    let weatherSummarylabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        
        return label
    }()
    
    var summary = ""{
        didSet{
            self.weatherSummarylabel.text = self.summary
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Weather Summary"
        
        view.backgroundColor = .white
        view.addSubview(weatherSummarylabel)
        
        weatherSummarylabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        weatherSummarylabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        weatherSummarylabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true
        
        weatherSummarylabel.text = summary
    }
}
