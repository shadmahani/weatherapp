//
//  FavoriteVC.swift
//  weather app
//
//  Created by hossein shademany on 5/26/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit

class FavoriteVC: UITableViewController {
    
    var favCities = Statics.shared.retrive()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(favCities)
        viewSetup()
        navigationSetup()
        tableViewSetup()
        print(favCities.count)
    }
    // MARK:- Setups
    func viewSetup(){
        view.backgroundColor = .red
    }
    func navigationSetup(){
        navigationItem.largeTitleDisplayMode = .never
    }
    func tableViewSetup(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
}

extension FavoriteVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favCities.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let favorite = favCities[indexPath.row]
        cell.textLabel?.text = favorite.name
        cell.backgroundColor = .green
        return cell
    }
    
}
