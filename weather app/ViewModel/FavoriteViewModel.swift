//
//  FavoriteViewModel.swift
//  weather app
//
//  Created by hossein shademany on 5/28/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit

class FavoriteViewModel {
    var favCities = LocalData.shared.retrive()
    var cities = [City]()
}
// MARK:- TableView data
extension FavoriteViewModel {
    
    func numberOfFavoriteCities()-> Int {
        return favCities.count
    }
    func changeFavoriteButton(cell: CityCell, index: Int){
        let favoriteCity = favCities[index]
        cell.cityNameLbl.text = favoriteCity.name
        if favoriteCity.isFaved {
            cell.faveButton.setImage(#imageLiteral(resourceName: "1"), for: .normal)
        }
        cell.city = favoriteCity
    }
    
    func goToCityDetail(from viewController: UIViewController, index: Int){
        let favoriteCity = favCities[index]
        ApiService.shared.currentWeather(cityName: "\(favoriteCity.lat),\(favoriteCity.lon)") { (result) in
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
