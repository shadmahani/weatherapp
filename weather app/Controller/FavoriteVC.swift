//
//  FavoriteVC.swift
//  weather app
//
//  Created by hossein shademany on 5/26/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit

class FavoriteVC: UITableViewController {
    
    var favCities = LocalData.shared.retrive()
    var cities = [City]()
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        navigationSetup()
        tableViewSetup()
    }
    // MARK:- Setups
    func viewSetup(){
        view.backgroundColor = .white
    }
    func navigationSetup(){
        navigationItem.largeTitleDisplayMode = .never
    }
    func tableViewSetup(){
        tableView.tableFooterView = UIView()
        tableView.register(CityCell.self, forCellReuseIdentifier: "cellID")
        tableView.rowHeight = 40
    }
}
// MARK:- TableView
extension FavoriteVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favCities.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CityCell
        let favoriteCity = favCities[indexPath.row]
        cell.cityNameLbl.text = favoriteCity.name
        if favoriteCity.isFaved {
            cell.faveButton.setImage(#imageLiteral(resourceName: "1"), for: .normal)
        }
        cell.city = favoriteCity

        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteCity = favCities[indexPath.row]
        ApiService.shared.currentWeather(cityName: "\(favoriteCity.lat),\(favoriteCity.lon)") { (result) in
            switch result {
            case .success(let value):
                let cityDetailVC = CityDetailVC()
                cityDetailVC.current = value
                self.navigationController?.pushViewController(cityDetailVC, animated: true)
            case .err(let err):
                print(err)
            }
        }
    }
    
    
}
