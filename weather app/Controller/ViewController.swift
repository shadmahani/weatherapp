//
//  ViewController.swift
//  weather app
//
//  Created by hossein shademany on 5/25/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var serchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    
    @IBAction func serchBtnTapped(_ sender: Any) {
        cities.removeAll()
        tableView.reloadData()
        
        guard let cityName = serchTextField.text else{return}
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
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
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

