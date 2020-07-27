//
//  ApiClient.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 27.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

class ApiClient: NSObject {
    
    var currenntCurrency: String    = "EUR"
    var rates = [Rate]()
    
    @objc public func loadRates(currency: String){
        let urlBased = "http://api.openrates.io/latest?base=\(currency)"
        guard let url = URL(string: urlBased) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    //Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                }
                else{
                    if data != nil{
                        do{
                            self.rates.removeAll()
                            let json = try JSONDecoder().decode(CurrencyData.self, from: data!)
                            for (key, value) in json.rates {
                                self.rates.append(Rate(currency: key, rate: value))
                            }
                            //self.currentCurrencyForShape.text = json.base
                            print(json.rates)
                            //self.dateLabel.text = "Last update: \(json.date)"
                            print("Last update: \(json.date)")
                            //self.currentCurrencyLabel.text = "Current currency: \(json.base)"
                            print("Current currency: \(json.base)")
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                //self.rateCollection.reloadData()
            }
        }
        task.resume()
    }

}
