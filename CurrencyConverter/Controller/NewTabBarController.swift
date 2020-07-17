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
            
        
        view.backgroundColor = .systemPink
        
        tabBar.barTintColor = .white
        
        let firstController = UINavigationController()
        firstController.pushViewController(ViewController(), animated: false)
        firstController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Recent"), tag: 0)
      
        let secondController = UINavigationController()
        secondController.pushViewController(ExchangeTableController(), animated: false)
        secondController.tabBarItem = UITabBarItem(title: "Cource board", image: UIImage(named: "Watch"), tag: 1)
        
        let thirdController = UINavigationController()
        thirdController.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        thirdController.tabBarItem = UITabBarItem(title: "Exchange", image: UIImage(named: "Card"), tag: 2)
        
        let forthController = UINavigationController()
        forthController.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        forthController.tabBarItem = UITabBarItem(title: "Statistics", image: UIImage(named: "Accepted"), tag: 3)
 
        let tabBarList = [firstController, secondController, thirdController, forthController]
        viewControllers = tabBarList
        
    }

}
