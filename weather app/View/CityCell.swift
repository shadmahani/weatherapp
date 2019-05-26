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

    
    var isFav: Bool = false
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

        if !isFav {

            faveButton.setImage(#imageLiteral(resourceName: "1"), for: .normal)
            isFav = true

        }else{
            faveButton.setImage(#imageLiteral(resourceName: "0"), for: .normal)
            isFav = false

        }
    }
}
