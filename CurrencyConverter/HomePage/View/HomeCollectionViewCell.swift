//
//  HomeCollectionViewCell.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 11.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

//protocol PassData: AnyObject {
//
//    // Try to convert it into function with these parametres for futher comfortable delegation
//    var firstLabel:  UILabel { get }
//    var secondLabel: UILabel { get }
//    var thirdabel:   UILabel { get }
//    var fourthLabel: UILabel { get }
//}


class HomeCollectionViewCell: UICollectionViewCell  {
    
    var firstLabel = UILabel()
    var secondLabel = UILabel()
    var thirdabel = UILabel()
    var fourthLabel = UILabel()
    let equalLabel = UILabel()
    
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
        contentView.addSubview(firstLabel)
        contentView.addSubview(secondLabel)
        contentView.addSubview(thirdabel)
        contentView.addSubview(fourthLabel)
        contentView.addSubview(equalLabel)
    }
    
    private func setUpConstraints() {
        
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            firstLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            firstLabel.heightAnchor.constraint(equalToConstant: 35),
            firstLabel.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            secondLabel.leadingAnchor.constraint(equalTo: firstLabel.trailingAnchor, constant: 10),
            secondLabel.heightAnchor.constraint(equalToConstant: 35),
            secondLabel.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        equalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            equalLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            equalLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            equalLabel.heightAnchor.constraint(equalToConstant: 35),
            equalLabel.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        thirdabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thirdabel.trailingAnchor.constraint(equalTo: fourthLabel.leadingAnchor, constant: -10),
            thirdabel.heightAnchor.constraint(equalToConstant: 35),
            thirdabel.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        fourthLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fourthLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            fourthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            fourthLabel.heightAnchor.constraint(equalToConstant: 35),
            fourthLabel.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    fileprivate func style(view: UIView) {
        view.layer.masksToBounds        = false
        view.backgroundColor            = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        view.layer.cornerRadius         = 5
        view.layer.shadowColor          = UIColor.black.cgColor
        view.layer.shadowOffset         = CGSize(width: 1, height: 5)
        view.layer.shadowRadius         = 8
        view.layer.shadowOpacity        = 0.2
        view.layer.shadowPath           = UIBezierPath(roundedRect: view.bounds,
                                                       byRoundingCorners: .allCorners,
                                                       cornerRadii: CGSize(width: 14, height: 14)).cgPath
        view.layer.shouldRasterize      = true
        view.layer.rasterizationScale   = UIScreen.main.scale
        
        firstLabel.textColor            = .white
        secondLabel.textColor           = .white
        thirdabel.textColor             = .white
        fourthLabel.textColor           = .white
        
        firstLabel.textAlignment = .right
        thirdabel.textAlignment = .right
        
        equalLabel.text = " = "
        equalLabel.textAlignment = .center
        equalLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    }
    
    public func updateData(currencyConvertation: CurrencyConvertation){
        firstLabel.text = String(currencyConvertation.enteredAmount)
        secondLabel.text = currencyConvertation.fromCurrency
        thirdabel.text = String(currencyConvertation.convertedAmount)
        fourthLabel.text = currencyConvertation.toCurrency
    }
}
