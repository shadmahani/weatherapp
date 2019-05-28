class Statics {
    static var shared = Statics()
    
    //    var foods = [Food]()
    
    func save(foods: [City]){
        do {
            let data = try JSONEncoder().encode(foods)
            UserDefaults.standard.set(data, forKey: "t1")
            
        }catch let err {
            print(err)
        }
    }
    func saveNew(food: City){
        var array = retrive()
        array.append(food)
        save(foods: array)
    }
    func remove(food: City) {
        var array = retrive()
        guard let index = array.firstIndex(where: {$0 == food}) else{return}
        array.remove(at: index)
        save(foods: array)
    }
    func retrive()->[City] {
        guard let data = UserDefaults.standard.data(forKey: "t1") else{
            return [City]()
        }
        do {
            let food = try JSONDecoder().decode([City].self, from: data)
            return food.removeDuplicates()
        }catch let err {
            print(err)
            return [City]()
        }
    }
}//
//  Statics.swift
//  weather app
//
//  Created by hossein shademany on 5/27/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import Foundation
