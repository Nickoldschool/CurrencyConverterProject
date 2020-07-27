//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 27.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

class CurrencyData: Decodable {
    let base: String
    let date: String
    let rates: [String: Double]
    
    init(base: String, date: String, rates: [String: Double]) {
        self.base   = base
        self.date   = date
        self.rates  = rates
    }
}

class Rate {
    let currency: String
    let rate: Double
    
    init(currency: String, rate: Double) {
        self.currency   = currency
        self.rate       = rate
    }
}
