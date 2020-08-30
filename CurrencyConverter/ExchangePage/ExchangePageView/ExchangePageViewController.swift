//
//  ExchangeViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 01.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

protocol ExchangePageViewControllerInput: AnyObject {
    
}

protocol ExchangePageViewControllerOutput {
    
}

final class ExchangePageViewController: UIViewController, ExchangePageViewControllerInput {
    
    var presenter: ExchangePageViewControllerOutput?
    
    let exchangeImage = UIImageView(image: UIImage(named: "ExchangeIllustration"))
    let firstUpArrow = UIImageView(image: UIImage(named: "UpArrow"))
    let firstDownArrow = UIImageView(image: UIImage(named: "DownArrow"))
    let secondUpArrow = UIImageView(image: UIImage(named: "UpArrow"))
    let secondDownArrow = UIImageView(image: UIImage(named: "DownArrow"))
    //    let firstWhiteView = UIView()
    //    let secondWhiteView = UIView()
    let purpleView = UIView()
    let scrollView = UIScrollView()
    let fromLabel = UILabel()
    let toLabel = UILabel()
    var fromTextField = UITextField()
    var toTextField = UITextField()
    let pushButton = UIButton()
    
    let exVC = HomePageViewController()
    
    //MARK: - Delegate
    
    weak var delegate: PassData?
    
    //MARK: - Stored properties
    
    var firstRate: Double {
        return Double(fromTextField.text ?? "") ?? 0
    }
    
    var secondRate: Double {
        return Double(toTextField.text ?? "") ?? 0
    }
    
    let firstPickerView = UIPickerView()
    let secondPickerView = UIPickerView()
    
    var firstCurrencyChoose = UITextField()
    var secondCurrencyChoose = UITextField()
    
    var networkManager = NetworkManager()
    var firstCurrency: String = "EUR"
    var secondCurrency: String = "RUB"
    
    var selectedCurrency: String?
    var currencies = ["RUB","EUR","USD","TRY","GBP","CZK","BGN","CNY","JPY","CAD","PHP","THB","SEK","PLN","AUD","SGD","INR",
                      "DKK","CHF","MYR","HKD","NOK","MXN","NZD","ZAR","HUF","HRK","KRW","ILS","RON","BRL","ISK","IDR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false )
        createElements()
        addSubviews()
        setupConstraints()
        registerForKeyboardNotifications()
    }
    
    deinit {
        removeForKeyboardNotification()
    }
    
    
    //MARK: - Creating elements to View
    
    private func createElements() {
        
        exchangeImage.contentMode = .scaleAspectFill
        
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
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        fromTextField.textColor = .black
        fromTextField.attributedPlaceholder = NSAttributedString(string: "Please,enter ammount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray ])
        fromTextField.keyboardType = .numberPad
        fromTextField.textAlignment = . center
        fromTextField.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        fromTextField.inputAccessoryView = toolBar
        
        toTextField.textColor = .black
        toTextField.attributedPlaceholder = NSAttributedString(string: "Please,enter ammount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray ])
        toTextField.keyboardType = .numberPad
        toTextField.textAlignment = . center
        toTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toTextField.inputAccessoryView = toolBar
        
        firstPickerView.delegate = self
        firstPickerView.dataSource = self
        firstCurrencyChoose.inputView = firstPickerView
        firstCurrencyChoose.textAlignment = .center
        firstCurrencyChoose.text = firstCurrency
        firstCurrencyChoose.textColor = .black
        firstCurrencyChoose.inputAccessoryView = toolBar
        
        secondPickerView.delegate = self
        secondPickerView.dataSource = self
        secondCurrencyChoose.inputView = secondPickerView
        secondCurrencyChoose.textAlignment = .center
        secondCurrencyChoose.text = secondCurrency
        secondCurrencyChoose.textColor = .black
        secondCurrencyChoose.inputAccessoryView = toolBar
        
        pushButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pushButton.setTitle("Save", for: .normal)
        pushButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        pushButton.layer.cornerRadius = 15
        pushButton.addTarget(self, action: #selector(pushToModelVC), for: .touchUpInside)
        
        firstCurrencyChoose.backgroundColor = .white
        secondCurrencyChoose.backgroundColor = .white
        
        firstUpArrow.backgroundColor = .white
        firstDownArrow.backgroundColor = .white
        secondUpArrow.backgroundColor = .white
        secondDownArrow.backgroundColor = .white
        
        //MARK: - method for dynamically change converted value
        fromTextField.addTarget(self, action: #selector(callNetwork), for: .editingChanged)
        
    }
    
    //MARK:- Picker View Button
    @objc func handleClick() {
        fromTextField.resignFirstResponder()
        toTextField.resignFirstResponder()
        firstCurrencyChoose.resignFirstResponder()
        secondCurrencyChoose.resignFirstResponder()
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
        purpleView.addSubview(firstCurrencyChoose)
        purpleView.addSubview(secondCurrencyChoose)
        purpleView.addSubview(pushButton)
        purpleView.addSubview(firstUpArrow)
        purpleView.addSubview(firstDownArrow)
        purpleView.addSubview(secondUpArrow)
        purpleView.addSubview(secondDownArrow)
        
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
            exchangeImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
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
            fromLabel.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 20),
            fromLabel.heightAnchor.constraint(equalToConstant: 40),
            fromLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        fromTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fromTextField.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 30),
            fromTextField.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 20),
            fromTextField.heightAnchor.constraint(equalToConstant: 40),
            fromTextField.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        firstCurrencyChoose.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstCurrencyChoose.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 30),
            firstCurrencyChoose.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -51),
            firstCurrencyChoose.heightAnchor.constraint(equalToConstant: 40),
            firstCurrencyChoose.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        firstUpArrow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstUpArrow.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 30),
            firstUpArrow.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -16),
            firstUpArrow.heightAnchor.constraint(equalToConstant: 20),
            firstUpArrow.widthAnchor.constraint(equalToConstant: 35),
        ])
        
        firstDownArrow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstDownArrow.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 50),
            firstDownArrow.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -16),
            firstDownArrow.heightAnchor.constraint(equalToConstant: 20),
            firstDownArrow.widthAnchor.constraint(equalToConstant: 35),
        ])
        
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toLabel.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 30),
            toLabel.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 20),
            toLabel.heightAnchor.constraint(equalToConstant: 40),
            toLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        toTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toTextField.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 30),
            toTextField.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 20),
            toTextField.heightAnchor.constraint(equalToConstant: 40),
            toTextField.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        secondCurrencyChoose.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondCurrencyChoose.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 30),
            secondCurrencyChoose.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -51),
            secondCurrencyChoose.heightAnchor.constraint(equalToConstant: 40),
            secondCurrencyChoose.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        secondUpArrow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondUpArrow.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 30),
            secondUpArrow.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -16),
            secondUpArrow.heightAnchor.constraint(equalToConstant: 20),
            secondUpArrow.widthAnchor.constraint(equalToConstant: 35),
        ])
        
        secondDownArrow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondDownArrow.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 50),
            secondDownArrow.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -16),
            secondDownArrow.heightAnchor.constraint(equalToConstant: 20),
            secondDownArrow.widthAnchor.constraint(equalToConstant: 35),
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
    
    //MARK: - Function for getting Data from Api
    
    @objc private func callNetwork() {
        
        networkManager.getTwoRates(firstRate: firstCurrency, secondRate: secondCurrency) { (currencies, error) in
            DispatchQueue.main.async {
                guard let rateCurrencies = currencies else { return self.toTextField.text = self.fromTextField.text }
                for (_, value) in rateCurrencies.rates  {
                    self.toTextField.text = String(round((value * self.firstRate)*100)/100)
                }
            }
        }
    }
    
    //MARK: - Pushing back to Home Controller for showing recent convertations
    
    @objc private func pushToModelVC() {
    
        let currencyConvertation = CurrencyConvertation(fromCurrency: firstCurrency,
                                                        toCurrency: secondCurrency,
                                                        enteredAmount: firstRate,
                                                        convertedAmount: secondRate)
        DataManager.shared.createCurrencyConvertation(model: currencyConvertation)
        navigationController?.pushViewController(exVC, animated: true)
    }
    
}

extension ExchangePageViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - Add Keyboard Observer for Notification Center
    
    private func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    //MARK: - Remove Keyboard Observer for Notification Center
    
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
    
    //MARK: - Picker View Configurations
    
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
        if pickerView == firstPickerView {
            firstCurrencyChoose.text = selectedCurrency
            firstCurrency = firstCurrencyChoose.text!
            callNetwork()
        } else {
            secondCurrencyChoose.text = selectedCurrency
            secondCurrency = secondCurrencyChoose.text!
            callNetwork()
        }
        
    }
    
}
