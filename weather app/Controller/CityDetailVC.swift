//
//  CityDetailVC.swift
//  weather app
//
//  Created by hossein shademany on 5/25/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit
import SnapKit
class CityDetailVC: UIViewController {
    
    var current: Current? {
        didSet{
            weatherText.text = current?.text
            print(current!.icon)
            weatherIcon.downloadImageWithCache(stringUrl: "http:\(current!.icon)")
        }
    }
    let weatherText: UILabel = {
        let lbl = UILabel()
        lbl.text = "Suny weather!"
        lbl.textAlignment = .center
        return lbl
    }()
    let weatherIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "swift")
        return iv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
         setupView()
    }
    func setupView(){
        view.addSubview(weatherIcon)
        view.addSubview(weatherText)
        
        weatherText.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        weatherIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.top.equalTo(weatherText.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(weatherIcon.snp.width)
        }
    }
}
