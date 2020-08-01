//
//  CourceCollectionViewCell.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 31.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

class CourceCollectionViewCell: UICollectionViewCell {
    
    let labelText = UILabel()
    let imageFlag = UIImageView(image: UIImage(named: ""))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews() 
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        
        style(view: contentView)
        contentView.addSubview(imageFlag)
        contentView.addSubview(labelText)
    }

    private func setUpConstraints() {
        
        imageFlag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageFlag.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5 ),
            imageFlag.heightAnchor.constraint(equalToConstant: 35),
            imageFlag.widthAnchor.constraint(equalToConstant: 40),
            imageFlag.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5 ),
        ])
        
        labelText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5 ),
            labelText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 115 ),
            labelText.heightAnchor.constraint(equalToConstant: 35),
            labelText.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    fileprivate func style(view: UIView) {
           view.layer.masksToBounds        = false
           view.backgroundColor            = .white
           view.layer.cornerRadius         = 5
           view.layer.shadowColor          = UIColor.black.cgColor
           view.layer.shadowOffset         = CGSize(width: 1, height: 5)
           view.layer.shadowRadius         = 8
           view.layer.shadowOpacity        = 0.2
           view.layer.shadowPath           = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 14, height: 14)).cgPath
           view.layer.shouldRasterize      = true
           view.layer.rasterizationScale   = UIScreen.main.scale
       }
       
//       public func updateData(rate: Rate, entery: Double){
//           currencyName.text               = rate.currency
//           currencyRate.text               = "Current rate: \(String(rate.rate))"
//           flagImage.image                 = UIImage(named: rate.currency)
//           if entery == 0{
//               resulLabel.text = ""
//           }else{
//               resulLabel.text = String(round((entery * rate.rate)*100)/100)
//           }
//           
//       }
}
