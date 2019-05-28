//
//  MainViewModel.swift
//  weather app
//
//  Created by hossein shademany on 5/28/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import Foundation
import UIKit
class MainViewModel {
    
    var cities = [City]()
    
}
// MARK:- Search bar
extension MainViewModel {
    func search(with text: String, completion: @escaping (_ success: Bool)->Void) {
        
        ApiService.shared.serach(cityName: text) { (result) in
            switch result {
            case .success(let value):
                self.cities = value
                completion(true)
                print(value)
                completion(false)
            case .err(let err):
                print(err)
            }
        }
    }
}
// MARK:- TableView data
extension MainViewModel {
    
    func numberOfCities()-> Int{
        return cities.count
    }
    
    func changeFavoriteButton(cell: CityCell, index: Int){
        var city = cities[index]
        cell.faveButton.setImage(#imageLiteral(resourceName: "0"), for: .normal)
        city.isFaved = false
        
        for faveCity in LocalData.shared.retrive() {
            if faveCity.id == city.id {
                print("EVEN")
                cell.faveButton.setImage(#imageLiteral(resourceName: "1"), for: .normal)
                city.isFaved = true
            }
        }
        cell.city = city
    }
    func cityLabel(index: Int,cell: CityCell){
        let city = cities[index]
        cell.cityNameLbl.text = city.name

    }
    func goToCityDetail(from viewController: UIViewController, index: Int){
        let city = cities[index]
        ApiService.shared.currentWeather(cityName: "\(city.lat),\(city.lon)") { (result) in
            switch result {
            case .success(let value):
                let cityDetailVC = CityDetailVC()
                cityDetailVC.current = value
                viewController.navigationController?.pushViewController(cityDetailVC, animated: true)
            case .err(let err):
                print(err)
            }
        }
    }
}
