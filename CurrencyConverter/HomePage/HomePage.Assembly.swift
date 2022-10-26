//
//  HomePage.Assembly.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

enum HomePage {}

extension HomePage {

	final class Assembly {

		static func assembly() -> UIViewController {

			let view = ViewController()
			let interactor = Interactor()
			let presenter = Presenter()
			let router = Router()

			view.presenter = presenter
			presenter.view = view
			presenter.interactor = interactor
			interactor.presenter = presenter
			presenter.router = router

			return view
		}
	}
}
