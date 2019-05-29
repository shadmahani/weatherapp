//  LocalData.swift
//  weather app
//
//  Created by hossein shademany on 5/27/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//
import Foundation

class LocalData {
    // True sigleton
    static var shared = LocalData()
    private init(){}
    
    func save(cities: [City]){
        do {
            let data = try JSONEncoder().encode(cities)
            UserDefaults.standard.set(data, forKey: "cities")
            
        }catch let err {
            print("err while saving data: /n" ,err)
        }
    }
    func add(city: City){
        var array = retrive()
        array.append(city)
        save(cities: array)
    }
    func remove(city: City) {
        var array = retrive()
        guard let index = array.firstIndex(where: {$0 == city}) else{return}
        array.remove(at: index)
        save(cities: array)
    }
    func retrive()->[City] {
        guard let data = UserDefaults.standard.data(forKey: "cities") else{
            return [City]()
        }
        do {
            let city = try JSONDecoder().decode([City].self, from: data)
            return city.removeDuplicates()
        }catch let err {
            print(err)
            return [City]()
        }
    }
}

