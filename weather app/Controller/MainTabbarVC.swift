//
//  MainTabbarVC.swift
//  weather app
//
//  Created by hossein shademany on 5/29/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//
import UIKit

class MainTabbarVC: UITabBarController {
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarSetup()
    }
    // MARK:- Setup
    func tabbarSetup(){
        // first vc
        let searchVC = SearchVC()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        // second vc
        let favoriteVC = FavoriteVC()
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    
        let controllers = [searchVC, favoriteVC]
        // nav for each VC
        viewControllers = controllers.map{UINavigationController(rootViewController: $0)}

        
    }
}
