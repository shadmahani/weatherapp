//
//  City.swift
//  weather app
//
//  Created by hossein shademany on 5/25/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import Foundation
import SwiftyJSON

struct City {
    
    let name: String
    let region: String
    let country: String
    
    init(json: JSON) {
        name = json["name"].stringValue
        region = json["region"].stringValue
        country = json["country"].stringValue
    }
}

