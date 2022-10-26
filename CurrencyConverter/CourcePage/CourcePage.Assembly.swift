//
//  CourcePage.Assembly.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 29.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

enum CourcePage {}

extension CourcePage {

	final class Assembly {

		func assembly() -> UIViewController {

			let view = ViewController()
			let presenter = Presenter()
			let interactor = Interactor()
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
