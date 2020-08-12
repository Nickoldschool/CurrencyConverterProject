//
//  CurrencyConvertationModel.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 12.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

struct CurrencyConvertation {
    let fromCurrency: String
    let toCurrency: String
    let enteredAmount: Double
    let convertedAmount: Double
    
    init(fromCurrency: String, toCurrency: String, enteredAmount: Double,convertedAmount: Double) {
        self.fromCurrency   = fromCurrency
        self.toCurrency   = toCurrency
        self.enteredAmount  = enteredAmount
        self.convertedAmount  = convertedAmount
    }
}

