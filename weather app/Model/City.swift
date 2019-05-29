//
//  City.swift
//  weather app
//
//  Created by hossein shademany on 5/25/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import Foundation
import SwiftyJSON

struct City: Codable,Equatable {
    
    private(set) var name: String
    private(set) var  region: String
    private(set) var  country: String
    private(set) var lon: String
    private(set) var lat: String
    private(set) var id: String
    var isFaved: Bool
    
    init(json: JSON) {
        name = json["name"].stringValue
        region = json["region"].stringValue
        country = json["country"].stringValue
        lon = json["lon"].stringValue
        lat = json["lat"].stringValue
        id = json["id"].stringValue
        isFaved = false
    }
    
   
}

