//
//  HomePageAssembly.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class HomePageAssembly {
    
    static func assembly() -> UIViewController {
        
        
        let view = HomePageViewController()
        let presenter = HomePagePresenter()
        
        view.presenter = presenter
        presenter.view = view as? HomePageViewInput
        
        let interactor = HomePageInteractor()
        interactor.presenter = presenter as? HomePageInteractorOutput
        presenter.interactor = interactor as? HomePageInteractorInput
        
        let router = HomePageRouter(view: view)
        presenter.router = router
        
        return view
    }

}
