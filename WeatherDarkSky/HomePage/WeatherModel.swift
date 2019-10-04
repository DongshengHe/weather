//
//  WeatherModel.swift
//  WeatherDarkSky
//
//  Created by Tony He on 2019/10/4.
//  Copyright © 2019 Tony He. All rights reserved.
//

import Foundation
import UIKit

struct WeatherModel:Codable {
    var latitude:CGFloat?
    var longitude:CGFloat?
    var timezone:String?
    var daily:WeatherModelDaily?
}

struct WeatherModelDaily:Codable {
    var summary:String?
    var icon:String?
    var data:[WeatherModelDailyData]?
}


struct WeatherModelDailyData:Codable {
    var time:Int?
    var summary:String?
    var icon:String?
    var temperatureHigh:CGFloat?
    var temperatureLow:CGFloat?
}
