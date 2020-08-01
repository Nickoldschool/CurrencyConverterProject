//
//  NewTabBarController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 17.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

class NewTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        view.backgroundColor = .white
        
        let firstController = UINavigationController()
        firstController.pushViewController(HomeViewController(), animated: false)
        firstController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "time"), tag: 0)
      
        let secondController = UINavigationController()
        secondController.pushViewController(CourceCollectionViewController(), animated: false)
        secondController.tabBarItem = UITabBarItem(title: "Cource board", image: UIImage(named: "grow portfolio"), tag: 1)
        
        let thirdController = UINavigationController()
        thirdController.pushViewController(ExchangeViewController(), animated: false)
        thirdController.tabBarItem = UITabBarItem(title: "Exchange", image: UIImage(named: "suitcase"), tag: 2)
        
        let forthController = UINavigationController()
        forthController.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        forthController.tabBarItem = UITabBarItem(title: "Statistics", image: UIImage(named: "grow"), tag: 3)
 
        let tabBarList = [firstController, secondController, thirdController, forthController]
        viewControllers = tabBarList
        
    }

}
