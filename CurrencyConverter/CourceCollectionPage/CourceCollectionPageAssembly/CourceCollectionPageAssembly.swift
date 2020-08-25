//
//  CourceBoardAssembly.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 29.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class CourceTablePageAssembly {
    
    func assembly() -> UIViewController {
        let view = CourceCollectionPageViewController()
        
        let presenter = CourceCollectionPagePresenter()
        let interactor = CourceCollectionPageInteractor()
        let router = CourceCollectionPageRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }

}
