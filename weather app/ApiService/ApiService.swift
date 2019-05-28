//
//  ApiService.swift
//  weather app
//
//  Created by hossein shademany on 5/25/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ApiService {
    // singleton instance
    static let shared = ApiService()
//    private init() {}
    var staticCities = [City]()
    func serach(cityName: String, completion: @escaping completion<[City]>){
        
        Alamofire.request("\(baseUrl)search.json?key=\(ApiKeys.weather.rawValue)&q=\(cityName)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (res) in
            guard res.result.error == nil else{
                completion(.err(res.result.error!))
                return
            }
            
            guard let data = res.data else {return}
            do {
                let json = try JSON(data: data)
                var cities = [City]()
                let arrayJson = json.arrayValue
                cities = arrayJson.compactMap({(json) -> City in return City(json: json)})
                completion(.success(cities))
                print(data)
            }catch let err {
                print(err)
            }
        }
    }
    
    
    func currentWeather(cityName: String, completion: @escaping completion<Current>){
        
        Alamofire.request("\(baseUrl)current.json?key=\(ApiKeys.weather.rawValue)&q=\(cityName)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (res) in
            guard res.result.error == nil else{
                completion(.err(res.result.error!))
                return
            }
            
            guard let data = res.data else{return}
            do {
                let json = try JSON(data: data)
                let condition = json["current"]["condition"].dictionaryValue

                guard let text = condition["text"]?.stringValue else{return}
                guard let icon = condition["icon"]?.stringValue else{return}
                let current = Current(text: text, icon: icon)
                completion(.success(current))

            }catch let err {
                print(err)
            }
        }
    }
    
    
    
}
