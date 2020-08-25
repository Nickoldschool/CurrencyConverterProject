//
//  ExchangePresenter.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 20.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class ExchangePagePresenter {

    weak var view: ExchangePageViewControllerInput?
    var interactor: ExchangePageInteractorInput?
    var router: ExchangePageRouterInput?
}

extension ExchangePagePresenter: ExchangePageViewControllerOutput {
    
}

extension ExchangePagePresenter: ExchangePageInteractorOutput {
    
}
