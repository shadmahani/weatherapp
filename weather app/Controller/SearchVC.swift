//
//  ViewController.swift
//  weather app
//
//  Created by hossein shademany on 5/25/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit
import SnapKit
class SearchVC: UIViewController {
    
    var viewModel = MainViewModel()
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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // reload after removing favorite cities to change the button image
        tableView.reloadData()
    }
    // MARK:- Setups
    func tableViewSetup(){
        tableView.tableFooterView = UIView()
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
        navigationController?.isToolbarHidden = true
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }

}
// MARK:- TableView
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCities()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CityCell
        
        viewModel.changeFavoriteButton(cell: cell, index: indexPath.row)
        viewModel.cityLabel(index: indexPath.row, cell: cell)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToCityDetail(from: self, index: indexPath.row)
    }
}
// MARK:- SearchBar
extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cities.removeAll()
        tableView.reloadData()
        
        guard let cityName = searchBar.text else{return}
        
        viewModel.search(with: cityName) { (success) in
            switch success {
            case true:
                self.tableView.reloadData()
            case false:
                //TODO: show message---
                print("err")
            }
        }
    }
}

