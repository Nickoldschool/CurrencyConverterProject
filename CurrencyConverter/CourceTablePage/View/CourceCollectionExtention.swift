//
//  CpurceTableExtention.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 30.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

extension CourceCollectionViewController {
    
    @objc public func loadRates(currency: String){
        let urlBased = "http://api.openrates.io/latest?base=\(currency)"
        guard let url = URL(string: urlBased) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if data != nil {
                    do {
                        self.rates.removeAll()
                        let json = try JSONDecoder().decode(CurrencyData.self, from: data!)
                        for (key, value) in json.rates {
                            //self.rates.append(Rate(currency: key, rate: value))
                            self.ratesKey.append(key)
                            self.ratesValue.append(value)
                        }
                        //print(self.ratesKey)
                        //print(self.ratesValue)
                        
                        self.currentCurrencyLabel.text = "Current currency: \(json.base)"
                        self.lastUpdateLabel.text = "Last update: \(json.date)"
                        
                        //self.currentCurrencyForShape.text = json.base
                        //print(json.rates)
                        print("Last update: \(json.date)")
                        print("Current currency: \(json.base)")
                    }
                    catch {
                        print(error)
                    }
                }
                //self.rateCollection.reloadData()
            }
        }
        task.resume()
    }
    
}
