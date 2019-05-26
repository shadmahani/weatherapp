//
//  FavoriteVC.swift
//  weather app
//
//  Created by hossein shademany on 5/26/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit

class FavoriteVC: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
        navigationSetup()
        tableViewSetup()
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
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}
