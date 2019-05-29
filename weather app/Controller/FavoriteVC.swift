//
//  FavoriteVC.swift
//  weather app
//
//  Created by hossein shademany on 5/26/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit

class FavoriteVC: UITableViewController {
    
    var viewModel = FavoriteViewModel()
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        tableViewSetup()
        notificationSetup()
    }
    // MARK:- Setups
    func viewSetup(){
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        // for updating favorite cities
        tableView.reloadData()
    }
    func notificationSetup(){
        NotificationCenter.default.addObserver(self, selector: #selector(favRemoved), name: NSNotification.Name("not fav"), object: nil)
    }

    func tableViewSetup(){
        tableView.tableFooterView = UIView()
        tableView.register(CityCell.self, forCellReuseIdentifier: "cellID")
        tableView.rowHeight = 40
    }
    
    // MARK:- Action
    @objc func favRemoved(){
        tableView.reloadData()
    }

}
// MARK:- TableView
extension FavoriteVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFavoriteCities()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CityCell
        
        viewModel.changeFavoriteButton(cell: cell, index: indexPath.row)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToCityDetail(from: self, index: indexPath.row)
    }
    
}
