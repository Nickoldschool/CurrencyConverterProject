//
//  CourcePage.Presenter.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 29.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

extension CourcePage {

	final class Presenter {

		weak var view: CourcePageViewInput?
		var interactor: CourcePageInteractorInput?
		var router: CourcePageRouterInput?
	}
}

extension CourcePage.Presenter: CourcePageViewOutput {}

extension CourcePage.Presenter: CourcePageInteractorOutput {}

