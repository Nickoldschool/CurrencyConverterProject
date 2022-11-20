//
//  ExchangePage.Interactor.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 23.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

protocol ExchangePageInteractorInput {}

protocol ExchangePageInteractorOutput: AnyObject {}

extension ExchangePage {

	final class Interactor {

		weak var presenter: ExchangePageInteractorOutput?
	}
}

extension ExchangePage.Interactor: ExchangePageInteractorInput {}
