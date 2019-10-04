//
//  API.swift
//  WeatherDarkSky
//
//  Created by Tony He on 2019/10/4.
//  Copyright © 2019 Tony He. All rights reserved.
//

import Foundation
import Alamofire

class API{
    //https://api.darksky.net/forecast/561b687e384f7403267229f3e4caedcc/37.8267,-122.4233
    
    private let darkskyPrivateKey = "561b687e384f7403267229f3e4caedcc"
    
    private let url = "https://api.darksky.net/forecast/"
    
    func getDarkSkyWeatherUrl(latitude:CGFloat,longitude:CGFloat) -> String {
        return url+darkskyPrivateKey + "/\(latitude),\(longitude)"
    }
}


enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func request(_ type : MethodType = .post, url : String, params : [String : Any]?,success : @escaping (_ data : Data)->(), failure : ((Int?, String) ->Void)?) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method: method, parameters: params).responseData { (response) in
            guard let json = response.data else {
                return
            }
            switch response.result {
            case let .success(response):
                    success(json)
            case let .failure(error):
                failureHandle(failure: failure, stateCode: nil, message: error.localizedDescription)
            }
        }
        
        
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            failure?(stateCode ,message)
        }

    }
}

extension NetworkTools{
    
    class func GET(url : String, params : [String : Any]?,success : @escaping (_ data : Data)->(), failure : ((Int?, String) ->Void)?) {
        print(url)
        NetworkTools.request(.get, url: url, params: params, success: success, failure: failure)
    }

    class func POST(url : String, params : [String : Any]?,success : @escaping (_ data : Data) ->(), failure : ((Int?, String) ->Void)?) {
        NetworkTools.request(.post, url: url, params: params,success: success, failure: failure)
    }
    
    
}
