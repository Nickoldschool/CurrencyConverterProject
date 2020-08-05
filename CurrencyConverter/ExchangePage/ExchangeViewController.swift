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
    let stackView = UIStackView()
    let enterValueFrom = UITextField()
    let fromLabel = UILabel()
    let toLabel = UILabel()
    let enterValueTo = UITextField()
    let exchangeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addElements()
        addSubviews()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        
        var _kbSize:CGSize!
        
        if let info = sender.userInfo {
            
            let frameEndUserInfoKey = UIResponder.keyboardFrameEndUserInfoKey
            
            //  Getting UIKeyboardSize.
            if let kbFrame = info[frameEndUserInfoKey] as? CGRect {
                
                let screenSize = UIScreen.main.bounds
                let intersectRect = kbFrame.intersection(screenSize)
                
                if intersectRect.isNull {
                    _kbSize = CGSize(width: screenSize.size.width, height: 0)
                } else {
                    _kbSize = intersectRect.size
                    view.frame.origin.y = view.frame.origin.y  - _kbSize.height + 40    // Move view up to keyboard height
                }
            }
        }
        
        
    }
    
    @objc func keyboardWillHide(sender: Notification) {
        view.frame.origin.y = 0 // Move view to original position
    }
    
    private func addElements() {
        
        exchangeImage.contentMode = .scaleToFill
        purpleView.backgroundColor = #colorLiteral(red: 0.6621792912, green: 2.986973641e-06, blue: 0.941290319, alpha: 1)
        purpleView.layer.cornerRadius = 15
        fromLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toLabel.textColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        enterValueFrom.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        enterValueTo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        exchangeButton.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        exchangeButton.setTitleColor( #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        fromLabel.text = "From"
        toLabel.text = "To"
        exchangeButton.setTitle("Exchange", for: .normal)
        enterValueFrom.textAlignment = .center
        enterValueTo.textAlignment = .center
        enterValueFrom.keyboardType = .decimalPad
        enterValueTo.keyboardType = .decimalPad
        enterValueFrom.layer.cornerRadius = 15
        enterValueTo.layer.cornerRadius = 15
        exchangeButton.layer.cornerRadius = 15
     
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
    }

    
    private func addSubviews() {
        
        view.addSubview(exchangeImage)
        view.addSubview(purpleView)
        purpleView.addSubview(stackView)
        stackView.addArrangedSubview(fromLabel)
        stackView.addArrangedSubview(enterValueFrom)
        stackView.addArrangedSubview(toLabel)
        stackView.addArrangedSubview(enterValueTo)
        stackView.addArrangedSubview(exchangeButton)
    }
    
    private func setupConstraints() {
        
        exchangeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exchangeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            exchangeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exchangeImage.heightAnchor.constraint(equalToConstant: 240),
            exchangeImage.widthAnchor.constraint(equalToConstant: 350),
        ])
        
        purpleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            purpleView.topAnchor.constraint(equalTo: exchangeImage.bottomAnchor, constant: 15),
            purpleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            purpleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            purpleView.widthAnchor.constraint(equalToConstant: 350),
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: purpleView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: purpleView.bottomAnchor, constant: -40),
        ])
        
    }
    
    
    
}

