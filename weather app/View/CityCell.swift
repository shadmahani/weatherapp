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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraintSetup()
    }
    override func layoutSubviews() {
        
//        if city.isFaved {
//            faveButton.setImage(#imageLiteral(resourceName: "1"), for: .normal)
//        }else{
//            faveButton.setImage(#imageLiteral(resourceName: "0"), for: .normal)
//        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func constraintSetup(){
        addSubview(faveButton)
        addSubview(cityNameLbl)
        
        faveButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(faveButton.snp.height)
            make.trailing.equalToSuperview()
        }
        cityNameLbl.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalTo(faveButton.snp.leading)
            make.top.bottom.equalToSuperview()
        }
        
    }
    @objc func favBtnTapped(){
        if !city.isFaved {
            faveButton.setImage(#imageLiteral(resourceName: "1"), for: .normal)
            print("fave")
            city.isFaved = true
            Statics.shared.saveNew(food: city)
            
            
        }else{
            faveButton.setImage(#imageLiteral(resourceName: "0"), for: .normal)
            Statics.shared.remove(food: city)
            city.isFaved = false
            print("not a fav")
        }
        
    }
}
