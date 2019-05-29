//
//  CityCell.swift
//  weather app
//
//  Created by hossein shademany on 5/26/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit
import SnapKit

class CityCell: UITableViewCell {
    
    var city: City!
    // MARK:- Components
    let cityNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "City name here!"
        return lbl
    }()
    lazy var faveButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "0"), for: .normal)
        btn.addTarget(self, action: #selector(favBtnTapped), for: .touchUpInside)
        return btn
    }()
    // MARK:- Life cyle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraintSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK:- Setup
    func constraintSetup(){
        addSubview(faveButton)
        addSubview(cityNameLbl)
        
        faveButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(faveButton.snp.height)
            make.trailing.equalToSuperview().offset(-10)
        }
        cityNameLbl.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(faveButton.snp.leading)
            make.top.bottom.equalToSuperview()
        }
        
    }
    // MARK:- Action
    @objc func favBtnTapped(){
        if city.isFaved {
            print(LocalData.shared.retrive().count)
            faveButton.setImage(#imageLiteral(resourceName: "0"), for: .normal)
            LocalData.shared.remove(city: city)
            city.isFaved = false
            NotificationCenter.default.post(name: NSNotification.Name("not fav"), object: nil)
            print(LocalData.shared.retrive().count)
        }else{
            faveButton.setImage(#imageLiteral(resourceName: "1"), for: .normal)
            city.isFaved = true
            LocalData.shared.add(city: city)

        }
    }
}
