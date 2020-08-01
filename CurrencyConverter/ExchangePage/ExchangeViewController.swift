//
//  ExchangeViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 01.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class ExchangeViewController: UIViewController {
    
    let exchangeImage = UIImageView(image: UIImage(named: "ExchangeIllustration"))
    let purpleView = UIView()
    let enterValueFrom = UITextField()
    let fromLabel = UILabel()
    let toLabel = UILabel()
    let enterValueTo = UITextField()
    let exchangeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImage()
        addEditField()
        setupConstraints()
    }
    
    private func configureImage() {
        
        exchangeImage.contentMode = .scaleToFill
        view.addSubview(exchangeImage)
    }
    
    private func addEditField() {
        
        purpleView.backgroundColor =  #colorLiteral(red: 0.6621792912, green: 2.986973641e-06, blue: 0.941290319, alpha: 1)
        fromLabel.text = "From"
        toLabel.text = "To"
        fromLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        enterValueFrom.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        enterValueTo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        exchangeButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        purpleView.layer.cornerRadius = 15
        enterValueFrom.layer.cornerRadius = 15
        enterValueTo.layer.cornerRadius = 15
        exchangeButton.layer.cornerRadius = 15
        exchangeButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        exchangeButton.setTitle("Exchange", for: .normal)
        view.addSubview(purpleView)
        purpleView.addSubview(fromLabel)
        purpleView.addSubview(toLabel)
        purpleView.addSubview(enterValueFrom)
        purpleView.addSubview(enterValueTo)
        purpleView.addSubview(exchangeButton)
    }

    private func setupConstraints() {
        
        exchangeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exchangeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            exchangeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exchangeImage.heightAnchor.constraint(equalToConstant: 240),
            exchangeImage.widthAnchor.constraint(equalToConstant: 350),
        ])
        
        purpleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            purpleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            purpleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            purpleView.heightAnchor.constraint(equalToConstant: 300),
            purpleView.widthAnchor.constraint(equalToConstant: 350),
        ])
        
        enterValueFrom.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   enterValueFrom.topAnchor.constraint(equalTo: purpleView.topAnchor, constant: 50),
                   enterValueFrom.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor),
                   enterValueFrom.heightAnchor.constraint(equalToConstant: 40),
                   enterValueFrom.widthAnchor.constraint(equalToConstant: 300),
               ])
        
        enterValueTo.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   enterValueTo.topAnchor.constraint(equalTo: purpleView.topAnchor, constant: 140),
                   enterValueTo.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor),
                   enterValueTo.heightAnchor.constraint(equalToConstant: 40),
                   enterValueTo.widthAnchor.constraint(equalToConstant: 300),
               ])
        
        exchangeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exchangeButton.bottomAnchor.constraint(equalTo: purpleView.bottomAnchor, constant: -40),
            exchangeButton.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor),
            exchangeButton.heightAnchor.constraint(equalToConstant: 40),
            exchangeButton.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fromLabel.topAnchor.constraint(equalTo: purpleView.topAnchor, constant: 10),
            fromLabel.trailingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 100),
            fromLabel.heightAnchor.constraint(equalToConstant: 40),
            fromLabel.widthAnchor.constraint(equalToConstant: 70),
        ])
        
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toLabel.topAnchor.constraint(equalTo: purpleView.topAnchor, constant: 100),
            toLabel.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 30),
            toLabel.heightAnchor.constraint(equalToConstant: 40),
            toLabel.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
    
 
    
}
