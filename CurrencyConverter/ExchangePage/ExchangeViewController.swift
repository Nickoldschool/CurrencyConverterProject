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
    
    var networkManager = NetworkManager()
    var firstCurrency: String = "EUR"
    var secondCurrency: String = "RUB"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createElements()
        addSubviews()
        setupConstraints()
        
        networkManager.getTwoRates(firstRate: firstCurrency, secondRate: secondCurrency) { (currencies, error) in
            
        }
        
        registerForKeyboardNotifications()
    }
    
    deinit {
        
        removeForKeyboardNotification()
    }
    
    //MARK: - Add Observer for Notification Center
    
    private func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    //MARK: - Remove Observer for Notification Center
    
    private func removeForKeyboardNotification() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

     //MARK: - Method for showing Keyboard
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
        
    }
    
    //MARK: - Method for hiding Keyboard
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        scrollView.contentOffset = CGPoint.zero
    }
    
    //MARK: - Creating elements to View
    
    private func createElements() {
        
        exchangeImage.contentMode = .scaleToFill
        
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 950 )
        scrollView.keyboardDismissMode = .onDrag
        scrollView.layer.cornerRadius = 15
        
        purpleView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        purpleView.layer.cornerRadius = 15
        
        fromLabel.layer.cornerRadius = 15
        fromLabel.text = "From"
        fromLabel.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        toLabel.layer.cornerRadius = 15
        toLabel.text = "To"
        toLabel.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        fromTextField.layer.cornerRadius = 15
        fromTextField.keyboardType = .decimalPad
        fromTextField.textAlignment = . center
        fromTextField.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        toTextField.layer.cornerRadius = 15
        toTextField.keyboardType = .decimalPad
        toTextField.textAlignment = . center
        toTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        pushButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pushButton.setTitle("Convert", for: .normal)
        pushButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        pushButton.layer.cornerRadius = 15
        pushButton.addTarget(self, action: #selector(pushToModelVC), for: .touchUpInside)
    }
    
    //MARK: - Adding elements to View
    
    private func addSubviews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(exchangeImage)
        scrollView.addSubview(purpleView)
        purpleView.addSubview(fromLabel)
        purpleView.addSubview(toLabel)
        purpleView.addSubview(fromTextField)
        purpleView.addSubview(toTextField)
        purpleView.addSubview(pushButton)
    }
    
    //MARK: - setup Constraints of elements
    
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
              purpleView.widthAnchor.constraint(equalToConstant: view.bounds.width - 50),
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
    
    //MARK: - Pushing back to Home Controller for showing recent convertations
    
    @objc private func pushToModelVC() {
        
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
    
}
