//
//  ExchangePage.Presenter.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

extension ExchangePage {

	final class Presenter {

		weak var view: ExchangePageViewControllerInput?
		var interactor: ExchangePageInteractorInput?
		var router: ExchangePageRouterInput?
	}
}

extension ExchangePage.Presenter: ExchangePageViewControllerOutput {}

extension ExchangePage.Presenter: ExchangePageInteractorOutput {}
