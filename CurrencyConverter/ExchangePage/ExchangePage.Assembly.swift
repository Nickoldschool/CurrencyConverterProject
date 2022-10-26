//
//  ExchangePage.Assembly.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

enum ExchangePage {}

extension ExchangePage {

	final class Assembly {

		func assembly() -> UIViewController {

			let view = ViewController()
			let interactor = Interactor()
			let presenter = Presenter()
			let router = Router()

			view.presenter = presenter
			presenter.view = view
			presenter.interactor = interactor
			presenter.router = router
			interactor.presenter = presenter

			return view
		}
	}
}
