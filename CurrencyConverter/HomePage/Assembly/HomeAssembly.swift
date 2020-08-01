//
//  HomePageAssembly.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class HomeAssembly {
    
    static func assembly() -> UIViewController {
        
        
        let view = HomeViewController()
        let presenter = HomePresenter()
        
        view.presenter = presenter
        presenter.view = view as? HomeViewInput
        
        let interactor = HomeInteractor()
        interactor.presenter = presenter as? HomeInteractorOutput
        presenter.interactor = interactor as? HomeInteractorInput
        
        let router = HomeRouter(view: view)
        presenter.router = router
        
        return view
    }

}
