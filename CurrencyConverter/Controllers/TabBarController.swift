//
//  TabBarController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 17.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		let firstController = UINavigationController(rootViewController: HomePage.ViewController())
		firstController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "time"), tag: 0)

		let secondController = UINavigationController(rootViewController: CourcePage.ViewController())
		secondController.tabBarItem = UITabBarItem(title: "Cource board", image: UIImage(named: "grow portfolio"), tag: 1)

		let thirdController = UINavigationController(rootViewController: ExchangePage.ViewController())
		thirdController.tabBarItem = UITabBarItem(title: "Exchange", image: UIImage(named: "suitcase"), tag: 2)

		//        let fourthController = UINavigationController()
		//        fourthController.tabBarItem = UITabBarItem(title: "Statistics", image: UIImage(named: "grow"), tag: 3)

		let tabBarList = [firstController, secondController, thirdController]
		viewControllers = tabBarList

	}
}
