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
    let scrollView = UIScrollView()
    let fromLabel = UILabel()
    let toLabel = UILabel()
    let fromTextField = UITextField()
    let toTextField = UITextField()
    let pushButton = UIButton()
    
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
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 950 )
        purpleView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        purpleView.layer.cornerRadius = 15
        //scrollView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        scrollView.layer.cornerRadius = 15
        fromLabel.layer.cornerRadius = 15
        toLabel.layer.cornerRadius = 15
        fromTextField.layer.cornerRadius = 15
        toTextField.layer.cornerRadius = 15
        fromTextField.keyboardType = .decimalPad
        toTextField.keyboardType = .decimalPad
        fromTextField.textAlignment = . center
        toTextField.textAlignment = . center
        fromLabel.text = "From"
        toLabel.text = "To"
        fromLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        fromTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pushButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pushButton.setTitle("Done", for: .normal)
        pushButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        pushButton.layer.cornerRadius = 15
        pushButton.addTarget(self, action: #selector(pushToModelVC), for: .touchUpInside)
    }

    @objc private func pushToModelVC() {
        
//        let modelVC = ModelViewController()
//        delegate?.showFirstRatelabel.text = fromTextField.text
//        delegate?.showSecondRatelabel.text = toTextField.text
//        navigationController?.pushViewController(modelVC, animated: true)
    }
    
    private func addSubviews() {
        
        //view.addSubview(exchangeImage)
        view.addSubview(scrollView)
        scrollView.addSubview(exchangeImage)
        scrollView.addSubview(purpleView)
        purpleView.addSubview(fromLabel)
        purpleView.addSubview(toLabel)
        purpleView.addSubview(fromTextField)
        purpleView.addSubview(toTextField)
        purpleView.addSubview(pushButton)
    }
    
    private func setupConstraints() {
                
        scrollView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        
        exchangeImage.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              exchangeImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
              exchangeImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
              exchangeImage.heightAnchor.constraint(equalToConstant: 240),
              exchangeImage.widthAnchor.constraint(equalToConstant: 350),
          ])
        
        purpleView.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              purpleView.topAnchor.constraint(equalTo: exchangeImage.bottomAnchor, constant: 50),
              purpleView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
              purpleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              //purpleView.heightAnchor.constraint(equalToConstant: 240),
              purpleView.widthAnchor.constraint(equalToConstant: 350),
          ])
        
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fromLabel.topAnchor.constraint(equalTo: purpleView.topAnchor, constant: 30),
            fromLabel.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor),
            fromLabel.heightAnchor.constraint(equalToConstant: 40),
            fromLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        fromTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fromTextField.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 30),
            fromTextField.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor),
            fromTextField.heightAnchor.constraint(equalToConstant: 40),
            fromTextField.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toLabel.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 30),
            toLabel.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor),
            toLabel.heightAnchor.constraint(equalToConstant: 40),
            toLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        toTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toTextField.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 30),
            toTextField.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor),
            toTextField.heightAnchor.constraint(equalToConstant: 40),
            toTextField.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pushButton.topAnchor.constraint(equalTo: toTextField.bottomAnchor, constant: 35),
            pushButton.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor),
            pushButton.heightAnchor.constraint(equalToConstant: 40),
            pushButton.widthAnchor.constraint(equalToConstant: 150),
            pushButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50),
        ])
        
    }
    
    
    
}

