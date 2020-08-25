//
//  HomeCollectionViewCell.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 11.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate  {
    
    var pan: UIPanGestureRecognizer!
    var deleteLabel1: UILabel!
    var deleteLabel2: UILabel!
    
    static let identifier = "HomeCollectionViewCell"  
    
    var firstLabel = UILabel()
    var secondLabel = UILabel()
    var thirdlabel = UILabel()
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
        contentView.addSubview(thirdlabel)
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
        
        thirdlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdlabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thirdlabel.trailingAnchor.constraint(equalTo: fourthLabel.leadingAnchor, constant: -10),
            thirdlabel.heightAnchor.constraint(equalToConstant: 35),
            thirdlabel.widthAnchor.constraint(equalToConstant: 80),
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
        //view.backgroundColor            = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        view.backgroundColor            = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
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
        thirdlabel.textColor             = .white
        fourthLabel.textColor           = .white
        
        firstLabel.textAlignment = .right
        thirdlabel.textAlignment = .right
        
        equalLabel.text = " = "
        equalLabel.textAlignment = .center
        equalLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        deleteLabel1 = UILabel()
        deleteLabel1.text = " Delete "
        deleteLabel1.textAlignment = .right
        deleteLabel1.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        deleteLabel1.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.1665322185, alpha: 1)
        self.insertSubview(deleteLabel1, belowSubview: self.contentView)

        deleteLabel2 = UILabel()
        deleteLabel2.text = " Delete "
        deleteLabel2.textAlignment = .left
        deleteLabel2.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        deleteLabel2.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.1665322185, alpha: 1)
        self.insertSubview(deleteLabel2, belowSubview: self.contentView)
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)

    }
    
    override func layoutSubviews() {
      super.layoutSubviews()

        if (pan.state == UIGestureRecognizer.State.changed) {
        let p: CGPoint = pan.translation(in: self)
        let width = self.contentView.frame.width
        let height = self.contentView.frame.height
        self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
        self.deleteLabel1.frame = CGRect(x: p.x - deleteLabel1.frame.size.width, y: 0,
                                         width: width, height: height)
        self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0,
                                         width: -width, height: height)
            
      }

    }

    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizer.State.began {

        } else if pan.state == UIGestureRecognizer.State.changed {
        self.setNeedsLayout()
      } else {
        if abs(pan.velocity(in: self).x) > 500 {
          let collectionView: UICollectionView = self.superview as! UICollectionView
          let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
          collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)),
                                                   forItemAt: indexPath, withSender: nil)
        } else {
          UIView.animate(withDuration: 0.2, animations: {
            self.setNeedsLayout()
            self.layoutIfNeeded()
          })
        }
      }
    }
    
    public func updateData(currencyConvertation: CurrencyConvertation){
        firstLabel.text = String(currencyConvertation.enteredAmount)
        secondLabel.text = currencyConvertation.fromCurrency
        thirdlabel.text = String(currencyConvertation.convertedAmount)
        fourthLabel.text = currencyConvertation.toCurrency
    }
    
}
