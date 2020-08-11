//
//  PopUpViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 10.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class PopUpViewController: UIViewController {
    
    var selectedCurrency: String?
    var currencies = ["PHP","THB","TRY","SEK","CNY","PLN","AUD","RUB","SGD","INR","DKK","CHF","MYR","HKD","EUR","NOK",
                      "MXN","NZD","ZAR","HUF","HRK","BGN","KRW","CAD","GBP","ILS","RON","BRL","ISK","CZK","JPY","IDR"]
    
    let containerView = UIView()
    let pickerView    = UIPickerView()
    let doneButton    = UIButton()
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate     = self
        pickerView.dataSource   = self
        setupNavBar()
        setupView()
        configureElements()
    }
    
    func setupView(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(containerView)
        view.addSubview(doneButton)
        
        containerView.addSubview(pickerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            containerView.heightAnchor.constraint(equalToConstant: 160),
            
        ])
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            pickerView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            pickerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
   
        ])
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            doneButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            doneButton.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            doneButton.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 35),
            
        ])
        
        doneButton.addTarget(self, action: #selector(handleDismiss), for: .allEvents)
    }
    
    private func configureElements() {
        pickerView.layer.cornerRadius = 5
        doneButton.layer.cornerRadius = 5
        pickerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        doneButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        doneButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        doneButton.setTitle("Close", for: .normal)
    }
    
    @objc fileprivate func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
}

extension PopUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencies[row]
        NotificationCenter.default.post(name: .selectedCurrency, object: self)
    }
    
}

extension Notification.Name {
    static let selectedCurrency = Notification.Name(rawValue: "selectedCurrency")
}

