//
//  ExchangeAssembly.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class ExchangePageAssembly {

    func assembly() -> UIViewController {
    
        let view = ExchangePageViewController()
        
        let interactor = ExchangePageInteractor()
        let presenter = ExchangePagePresenter()
        let router = ExchangePageRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
