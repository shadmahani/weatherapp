//
//  ViewController.swift
//  weather app
//
//  Created by hossein shademany on 5/25/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit
import SnapKit
class MainVC: UIViewController {
    
    var cities = [City]()
    var favoriteCities = [City]()
    // MARK:- Components
    var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
  
   // MARK:- Life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        constraintSetup()
        searchControllerSetup()
        navigationSetup()
       
    }
    // MARK:- Setups
    func navigationSetup(){
        title = "Weather app!"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let barButton = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(barbuttonTapped))
        navigationItem.rightBarButtonItem = barButton
    }
    func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityCell.self, forCellReuseIdentifier: "cellID")
        tableView.rowHeight = 40
    }
    func constraintSetup(){
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func searchControllerSetup(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    // MARK:- Actions
    @objc func barbuttonTapped(){
        navigationController?.pushViewController(FavoriteVC(), animated: true)
    }
}
// MARK:- TableView
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CityCell
        let city = cities[indexPath.row]
        // reset the fave button image
        cell.faveButton.setImage(#imageLiteral(resourceName: "0"), for: .normal)
        cell.cityNameLbl.text = city.name

        for faveCity in LocalData.shared.retrive() {
            if faveCity.id == city.id {
                print("EVEN")
                cell.faveButton.setImage(#imageLiteral(resourceName: "1"), for: .normal)
                
            }
        }

        cell.city = city
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        ApiService.shared.currentWeather(cityName: "\(city.lat),\(city.lon)") { (result) in
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
// MARK:- SearchBar
extension MainVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        cities.removeAll()
        tableView.reloadData()
        
        guard let cityName = searchBar.text else{return}
        ApiService.shared.serach(cityName: cityName) { (result) in
            switch result {
            case .success(let value):
                self.cities = value
                self.tableView.reloadData()
                print(value)
            case .err(let err):
                print(err)
            }
        }
    }
}

