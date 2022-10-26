//
//  HomePage.Router.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

protocol HomePageRouterInput {

	func closeModule()
}


extension HomePage {

	final class Router {}
}

extension HomePage.Router: HomePageRouterInput {

	func closeModule() {}
}
