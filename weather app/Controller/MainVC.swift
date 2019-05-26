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
    
    // MARK:- Components
    var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    var cities = [City]()
    
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
    }
    func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        ApiService.shared.currentWeather(cityName: city.region) { (result) in
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

