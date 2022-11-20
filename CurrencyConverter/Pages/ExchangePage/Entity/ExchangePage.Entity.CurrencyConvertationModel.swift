//
//  ExchangePage.Entity.CurrencyConvertationModel.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 12.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import Foundation

extension ExchangePage.Entity {

	struct CurrencyConvertation {
		let fromCurrency: String
		let toCurrency: String
		let enteredAmount: Double
		let convertedAmount: Double
	}
}
