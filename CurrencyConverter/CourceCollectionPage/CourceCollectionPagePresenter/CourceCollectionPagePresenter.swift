//
//  CourceTabPagePresenter.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 29.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class CourceCollectionPagePresenter {
    
    weak var view: CourceCollectionPageViewInput?
    var interactor: CourceCollectionPageInteractorInput?
    var router: CourceCollectionPageRouterInput?

}

extension CourceCollectionPagePresenter: CourceCollectionPageViewOutput {
    
}

extension CourceCollectionPagePresenter: CourceCollectionPageInteractorOutput {
    
}

