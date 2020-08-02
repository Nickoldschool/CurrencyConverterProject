//
//  HomePageRouter.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

protocol HomeRouterInput {
    
    func closeModule()
}

final class HomeRouter: HomeRouterInput {

    unowned let view: UIViewController
       
       init(view: UIViewController) {
           self.view = view
       }
    
    func closeModule() {
           view.dismiss(animated: true, completion: nil)
       }
    
}
