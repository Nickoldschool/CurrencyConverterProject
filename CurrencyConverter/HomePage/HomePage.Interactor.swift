//
//  HomePage.Interactor.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

protocol HomePageInteractorInput {
	func loadInfo()
}

protocol HomePageInteractorOutput: AnyObject {
	func infoLoaded()
}

extension HomePage {

	final class Interactor: HomePageInteractorInput {

		weak var presenter: HomePageInteractorOutput?

		func loadInfo() {
			presenter?.infoLoaded()
		}
	}
}
